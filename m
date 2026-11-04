Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757267;
	b=4xWyD4YCCOVvUB2AFGIiXt8u0ecZD/VwohCkQf+FdpWzbmBuVb2uoxG1Yz0wM7NIcyIb
	 ToqodO1S06F3bFx9lbI1wAcoRUmiQz3wO+11St+iMa6mdNESNtIqYjXtzBcCCaaMxvMLj
	 PEON4N+A0sCG7bwwJ52pUcYpSvpRPDfLcZYDodHQxbXLIQwDdQLxlBd1VastbKWu/T95u
	 nlviZC6fRCcOPXvwsewEEEx67J3SSvHy/9u0uO+p8Inal50W8ddd3+L0aZvtBcvk7ILdi
	 T4cKAfDnTrP3v1Jgr8vN8Y9LKyugN0urUgFY3Qodn7GYwz67CtAxl4rNmHAT9YXsz6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757267;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=zRnz3/Ug+GCrmGI3GdLPJBCXz6wHkKINh/ebX7cgXt8=;
	b=rAbVtEwC3he5u9meI5a3QgRbOkJkrKATq/G4EkhxPWBX4PU3t61V2S+RYeIvLdWbJa/Q
	 UR/p+BCFXLBTe9I1TCrqbOpN9y7mDb6OTgu623KBgPQj5HpXz50hl0ftU4guCvtkMWsHU
	 1CUbu+q0ExBctO5/kIrQfnHEh6KrSXIsvVl1E3imF5IwX9uBvFXWtRTZlk8yQJJ7kJ1CR
	 N5hqbDF0TLpHtMTxawxDluK2svFWoztOjkNWTnv8bZg+3rm9z3/QUzzfpocxgMjd3XAwl
	 IyoLnvMg8XMg9meI8IVSALbtpwV38zCCBnzGh1Bm+hFXsAASkf4tsRbrKk/eo5hR1IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=aT84liL2;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C0606A333;
	Wed,  4 Nov 2026 01:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C21C0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=aT84liL2
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40STr23727576;
	Tue, 3 Nov 2026 17:54:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=zRnz3/Ug+GCrmGI3GdLPJBCXz6wHkKINh/ebX
	7cgXt8=; b=aT84liL2iyvH4SnyDb8m91e5DC8zSdBRJm83P8UAlp/oYub0l6IBK
	d1VW/2tNCEK7T4DbCGbmVlBP0UE8z5UPE2MbluBhq2yAgR/+wb+QdHgPXMxiq8mk
	qtuoYGawd8jJ9dDEJa7ZbR1qMU4Ie18S+BIyJQvwW6okpxe87Blkb37w2d5zynfP
	9fqXunwHLX0sbRcpgflwbc4PlHdwtDXAqretJNCzzPt9bpL5XnaMZM0SJOjLNLsv
	vPuK5ygBuaCPv0S+dfXpmMjym4I2QfvMWVEOrR8Cm7A2em6nGV1LrzvRFRgOKyvF
	clBQhsMhMGKEEX/DZsv2TgItQ05IsZ7nw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hqbb1qbu4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Nov 2026 17:54:03 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 4 Nov
 2026 01:54:02 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Tue, 3 Nov 2026 17:53:17 -0800
Subject: [PATCH net-next v5 2/7] vsock: rename the vsock pernet operations
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261103-vsock-guest-ns-v5-2-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Shuah Khan
	<shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Donald Hunter
	<donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>,
        Eric Dumazet
	<edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: UBBzTY9lMwaSCULDLVFenqPLvBbN7ui-
X-Authority-Analysis: v=2.4 cv=LsIHWXdc c=1 sm=1 tr=0 ts=6aea903b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=20KFwNOVAAAA:8
 a=VabnemYjAAAA:8 a=-BBy4ptD6Xa2-Mryg3AA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX5KlpI+bBkznl
 zHbvsvgY8WoZTYbsolYlrBJwbzDZ4RHSeDgCahIMlLMO+zWT4iAWHb2v9x6Ze/lrNulyB0cGyki
 7Bt8mxwx93ERRBiPi6AiC+RTo5NVk1wyzfRT7fHE1aayinCtHzR4jnNJ3rXluooImn0jLVI4j5y
 P0kO9Cvw/WpM1Ij2bbsgRFbd5caw4xYL2GlFWzATXEC3TkgsoEMZTmT4HRp/A0WDShfVXRtS6Se
 QJcy5F8spdLc4k6yghQ2XwY0oIdywsnz/j6XrXWHR6lcsEmF4Gky1MlQfh+TGm/HWtondPCyqRn
 GLPPI3rQfwH/N+lqsFFBBRW88IJzggR6+A+oD1diMWjKjuilbnqHoH32Ch4r5Eyqf/9sw3pJKFe
 y2f97p/Hw5bBSiCWNiYQTGvt0cvHskyBNSJ+yNYML+7rqh1pSTo9CaIFY0lYW/kK76zzSm6ypNA
 ItAUCtNWw1TWzwOSu/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX+dIZg73+xGVp
 BiqWuSubtS+7nSvVnWHJD2e4cbf9bZa5mS25t6ovqjfCvvKTcvz+mBmZbZ3WM/nVSCLKlGE0Ysq
 9vmWgIbwWNpK0u7s9gSJPIQWsr1IkRs=
X-Proofpoint-ORIG-GUID: UBBzTY9lMwaSCULDLVFenqPLvBbN7ui-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01

vsock_sysctl_ops and its two callbacks are named for the sysctl tables
they register, but the init callback already does more than that: it
also initialises the per-namespace vsock state through vsock_net_init().

Rename them to vsock_pernet_ops, vsock_pernet_init and
vsock_pernet_exit, so that later per-namespace work can be placed here
too.

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/af_vsock.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5a0ba068bfd1..aa4732c3599f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -3037,7 +3037,7 @@ static void vsock_net_init(struct net *net)
 	net->vsock.g2h_fallback = 1;
 }
 
-static __net_init int vsock_sysctl_init_net(struct net *net)
+static __net_init int vsock_pernet_init(struct net *net)
 {
 	vsock_net_init(net);
 
@@ -3047,14 +3047,14 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
 	return 0;
 }
 
-static __net_exit void vsock_sysctl_exit_net(struct net *net)
+static __net_exit void vsock_pernet_exit(struct net *net)
 {
 	vsock_sysctl_unregister(net);
 }
 
-static struct pernet_operations vsock_sysctl_ops = {
-	.init = vsock_sysctl_init_net,
-	.exit = vsock_sysctl_exit_net,
+static struct pernet_operations vsock_pernet_ops = {
+	.init = vsock_pernet_init,
+	.exit = vsock_pernet_exit,
 };
 
 static int __init vsock_init(void)
@@ -3084,7 +3084,7 @@ static int __init vsock_init(void)
 		goto err_unregister_proto;
 	}
 
-	if (register_pernet_subsys(&vsock_sysctl_ops)) {
+	if (register_pernet_subsys(&vsock_pernet_ops)) {
 		err = -ENOMEM;
 		goto err_unregister_sock;
 	}
@@ -3108,7 +3108,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
-	unregister_pernet_subsys(&vsock_sysctl_ops);
+	unregister_pernet_subsys(&vsock_pernet_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)

-- 
2.53.0-Meta

