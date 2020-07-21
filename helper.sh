# export HOST_IP=$(ipconfig getifaddr en0)
# export CONSUL_ADDR=https://$HOST_IP:8500

# export CONSUL_HTTP_ADDR=$(minikube service consul-ui -p cluster-1 --https --url)

function consul1 {
    CONSUL_HTTP_ADDR=$(minikube service consul-ui -p cluster-1 --https --url)
    echo -n | openssl s_client -connect ${CONSUL_HTTP_ADDR//https:\/\/}  | \
        sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > cluster-1.cert

    echo "consul $1 -http-addr=$CONSUL_HTTP_ADDR -ca-file=cluster-1.cert -tls-server-name=127.0.0.1 $2" | bash
    rm -f cluster-1.cert
}
function consul2 {
    CONSUL_HTTP_ADDR=$(minikube service consul-ui -p cluster-2 --https --url)
    echo -n | openssl s_client -connect ${CONSUL_HTTP_ADDR//https:\/\/}  | \
        sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > cluster-2.cert

    echo "consul $1 -http-addr=$CONSUL_HTTP_ADDR -ca-file=cluster-2.cert -tls-server-name=127.0.0.1 $2" | bash
    rm -f cluster-2.cert
}

function c1_kctl {
    kubectl config use-context cluster-1
    kubectl $*
}

function c2_kctl {
    kubectl config use-context cluster-2
    kubectl $*
}

function c1_kctx {
    kubectl config use-context cluster-1
}
function c2_kctx {
    kubectl config use-context cluster-2
}

# PATH TO YOUR HOSTS FILE
ETC_HOSTS=/etc/hosts
function removehost() {
    HOSTNAME=$1
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
    then
        echo "$HOSTNAME Found in your $ETC_HOSTS, Removing now...";
        sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS
    else
        echo "$HOSTNAME was not found in your $ETC_HOSTS";
    fi
}

function addhost() {
    HOSTNAME=$1
    IP=$2
    HOSTS_LINE="$IP\t$HOSTNAME"
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
        then
            echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
        else
            echo "Adding $HOSTNAME to your $ETC_HOSTS";
            sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";

            if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
                then
                    echo "$HOSTNAME was added succesfully \n $(grep $HOSTNAME /etc/hosts)";
                else
                    echo "Failed to Add $HOSTNAME, Try again!";
            fi
    fi
}
