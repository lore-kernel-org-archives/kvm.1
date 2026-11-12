Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511248;
	b=WacBMYn7zoZM1bZCOrchKVwvD9LukHORZwolGL2UtMAkb5M1rfWHglHzu68AAmLijaQp
	 o4xNQNnva6P3aqqP+BBS3LzphttqoZllqk2jS2s2Yxwvba07C5QApbi5ctVZS5QFVYUg0
	 CCWzkhkdIQDKSNd/NlKql20mCMv0LfCcgkqmUyr6ylKCr78O7eSBIBo5h0ZNCKIseP/DQ
	 upnQPPWlXOB0wABZ+jZEmg1nK252kXLxgc1Fq3fGUKfEYSKzkblZ4Tu/a7GnWlre2jV9g
	 09gQtyAjUud/U0U/XfxjorSamE9FdZaDkbDNucPpOMtGeCoXAc1yjCZ+sfhmOA93qKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511248;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=v/YioOVQin3KFuWXwOiFXbRbDlfWyZR4IkZliHHOkXg=;
	b=tINZwCS6Rr0kVvsfH2E+RD3v2UIwI7t4Te149zyPitLUEQZXVh5e+JxxX/OST+qprxbC
	 regyeI1K16pgdbxbkST0u5Zh6ab5zHjr6qipnomRm4eYq1fBx7w7tbKuafHZR17Hs9p0i
	 2XGq0DklAEdMgqfR+d04o31pCAAH/nBIsrt3Oow3QeC0ltcaEzidW5X0xQEzu8+yITswR
	 DzeT04ScE4q2CUg/1LWK6E/UG2kl6IZ89WnW1GzW/mcjoUSZBjkbth/JODUTPmRjU9LTZ
	 YIYloS/BinjD5AzqYOAmdV9Qn/ZVHssQhmpizwo1fxRoJ50E5cZ1uzpi6HNVArB/W7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=mBPUACCh;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE51606A31C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 19:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CE51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=mBPUACCh
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFalW9183540;
	Thu, 12 Nov 2026 11:20:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=v/YioOVQin3KFuWXwOiFXbRbDlfWyZR4IkZli
	HHOkXg=; b=mBPUACChT+MURotoMhctfvSQrXx47h+IrKsVFwn0ctyYrY0LvqTHT
	d/lGmkzmNtqiGX6sGwqXPdBeBLWtKR/R6K4gW3egQUku7Pg8fEdmMwjX2fI+GKMY
	Ks5S44hlT1QrjK25b6mLRLHQUShlqYxJj5IigIfW6/bw805Sxl+afFU78TrqFMq6
	Q6OuLggRtiJQaMI3YDZPqeSKFNILdAmrsh9W3wn9cJnZQUQHDMWO1+BIFRylaJ9R
	PN87nGHsyjWW+q3xI20cQGG8a6AXcV6fnvAyiw+t3He/cGyz8PwQCbxmTlTud0nu
	PAjLHSAxnGFt90bFabYakHeYRBky49diA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hvahfrbj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Nov 2026 11:20:44 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 12 Nov
 2026 19:20:44 +0000
Date: Thu, 12 Nov 2026 11:20:43 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>,
        "Michael S.
 Tsirkin" <mst@redhat.com>,
        Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH net-next v5 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Message-ID: <avYRi9reTERM9O2/@devvm29614.prn0.facebook.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-4-48179b9b66b8@meta.com>
 <sashiko-outbox-198420@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-198420@kernel.org>
X-Proofpoint-ORIG-GUID: BIDSt9FsOSAfs28UfiQ8yeTOyLYaPiMZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3NyBTYWx0ZWRfX7cMkqfNSz/ws
 ksEQU0aPXHLkncCL5UGnPYKrZMdUWEz5uAimI07FEgYkLvnzeTk/GczYQMPGXs17NENpcIRkRNt
 VwBykjMg6DG8tBNi/+Jw/CM3ir1Vo08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3NyBTYWx0ZWRfX4r+2OHzQGJ1I
 nYYmFY9v0M8Vaq1+S4YQACRtTCD/ozRBYc6hWGCGvqZzhdhKQfOXMgylAbqDhzctREz7Njrydlj
 eESVbj1998eTC12g1uHsDpfNw/vUsNV0S/KWsK5h8tsCHW3MB0BtOgJnWsMHK+/lyRwPg2rUNS4
 iIO5Y+1BZLDaPSBpX51TahaEX98vVAgt0rQJtwpOztPmHee+eLEYcda1SUHGjVHA49GMxAS4wxp
 +OHF1EQgv0lk8e4wwxOquQdEaVJBqnOPhxIl9SInwjIouQzJnAYSWud2zIIVHxwcXJ9F6DFmzml
 8IK++FQrYt5Qcx/2HBBvJ5g0pvAg7JMpGJ6dEl0Tl81xIrpPLV4dDOzOa2MdqcRfHdccXpSy6IJ
 2uzxVAXfSUFcKKc8SxJfJ/ELqO/ExV752dDBdrjlbmumJT0Yez7fTEXb1nDIP7jj2QNxMR2MDQT
 087v95P745Fsuyz7Zyw==
X-Proofpoint-GUID: BIDSt9FsOSAfs28UfiQ8yeTOyLYaPiMZ
X-Authority-Analysis: v=2.4 cv=HuPjiETS c=1 sm=1 tr=0 ts=6af6118d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=Z8m0FVilGhqSmMIZlYEA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01

On Thu, Nov 05, 2026 at 01:54:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] vsock: connect() corrupts state and bytes_unsent on swept established socket
> --
> 
> commit 1f8c2b3f7e5cf0bf0bba26600e236377dd6b1fe3
> Author: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> vsock: add a netlink command to assign the g2h device to a netns
> 
> This commit introduces a vsock generic netlink family with
> VSOCK_CMD_DEV_NETNS_SET and VSOCK_CMD_DEV_NETNS_GET to assign the
> guest-to-host vsock device to a network namespace and query its assignment.
> Sockets that can no longer reach the device after an assignment are closed
> with ECONNRESET.
> 
> Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
> 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index c9b28e34b1b3c..7140a3c708389 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> 
> [ ... ]
> 
> > @@ -742,8 +868,269 @@ bool vsock_find_cid(unsigned int cid)
> 
> [ ... ]
> 
> > +/* Close every connected socket of @t that can no longer reach the g2h device.
> > + */
> > +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
> > +{
> > +	struct vsock_sock *vsk;
> > +	unsigned int i = 0;
> > +	struct sock *sk;
> > +	bool reset;
> > +
> > +	lockdep_assert_held(&vsock_g2h_assign_mutex);
> > +	lockdep_assert_not_held(&vsock_register_mutex);
> > +
> > +	/* lock_sock() cannot be taken under vsock_table_lock, so pick the
> > +	 * sockets one at a time, then recheck each under both locks.
> > +	 */
> > +	while ((sk = vsock_next_connected_socket(t, &i,
> > +						 vsock_g2h_should_reset))) {
> > +		vsk = vsock_sk(sk);
> > +
> > +		lock_sock(sk);
> > +
> > +		reset = false;
> > +		spin_lock_bh(&vsock_table_lock);
> > +		/* It may have been closed since we dropped the table lock. */
> > +		if (__vsock_in_connected_table(vsk) && vsk->transport == t &&
> > +		    vsock_g2h_should_reset(vsk)) {
> > +			__vsock_remove_connected(vsk);
> > +			reset = true;
> > +		}
> > +		spin_unlock_bh(&vsock_table_lock);
> > +
> > +		if (reset) {
> > +			sock_set_flag(sk, SOCK_DONE);
> > +			WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
> > +			sk->sk_state = TCP_CLOSE;
> > +			sk->sk_err = ECONNRESET;
> > +			sk_error_report(sk);
> > +		}
> > +
> > +		release_sock(sk);
> > +		sock_put(sk);
> > +	}
> > +}
> 
> [ ... ]
> 
> > @@ -1705,6 +2093,16 @@ static void vsock_connect_timeout(struct work_struct *work)
> >  	sock_put(sk);
> >  }
> >  
> > +/* Avoid breaking the socket when another thread has changed its sock->state
> > + * while we were asleep.
> > + */
> > +static void vsock_connect_close(struct socket *sock)
> > +{
> > +	sock->sk->sk_state = TCP_CLOSE;
> > +	if (sock->state == SS_CONNECTING)
> > +		sock->state = SS_UNCONNECTED;
> > +}
> > +
> >  static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> >  			 int addr_len, int flags)
> >  {
> > @@ -1863,8 +2261,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> >  			 * sk_state == TCP_SYN_SENT, which hereby we break.
> >  			 * In such case VIRTIO_VSOCK_OP_RST will follow.
> >  			 */
> > -			sk->sk_state = TCP_CLOSE;
> > -			sock->state = SS_UNCONNECTED;
> > +			vsock_connect_close(sock);
> >  
> >  			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
> >  			 * transport->connect().
> > @@ -1878,10 +2275,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> >  	}
> >  
> >  	err = sock_error(sk);
> > -	if (err) {
> > -		sk->sk_state = TCP_CLOSE;
> > -		sock->state = SS_UNCONNECTED;
> > -	}
> > +	if (err)
> > +		vsock_connect_close(sock);
> 
> [Severity: Medium]
> What happens in vsock_connect() when a socket reaches TCP_ESTABLISHED while
> sleeping in schedule_timeout(), and is then swept by
> vsock_g2h_reset_unreachable() before vsock_connect() reacquires
> lock_sock(sk)?
> 
> While vsock_connect() has released lock_sock(sk) in schedule_timeout(),
> virtio_transport_recv_connecting() can receive VIRTIO_VSOCK_OP_RESPONSE,
> transition sk->sk_state to TCP_ESTABLISHED, set sock->state to SS_CONNECTED,
> and insert vsk into vsock_connected_table. Once established, a concurrent
> vsock_connectible_sendmsg() on another thread can acquire credits via
> virtio_transport_get_credit() (incrementing vvs->bytes_unsent) and enqueue
> VIRTIO_VSOCK_OP_RW skbs onto send_pkt_queue.
> 
> If VSOCK_CMD_DEV_NETNS_SET then runs vsock_g2h_reset_unreachable() before
> vsock_connect() reacquires lock_sock(sk), it sets sk->sk_state to TCP_CLOSE
> and sk->sk_err to ECONNRESET while leaving sock->state as SS_CONNECTED. When
> vsock_connect() wakes up, the once-established check:
> 
> 	if (sk->sk_state == TCP_ESTABLISHED ||
> 	    sk->sk_state == TCP_CLOSING) {
> 		err = 0;
> 		goto out_wait;
> 	}
> 
> does not match because sk->sk_state is TCP_CLOSE rather than TCP_CLOSING (unlike
> virtio_transport_do_close()) and sock->state == SS_CONNECTED is not checked.
> 
> If signal_pending(current) || timeout == 0 holds, vsock_connect() proceeds to
> call vsock_transport_cancel_pkt(vsk) -> virtio_transport_purge_skbs(), which
> purges the post-connection VIRTIO_VSOCK_OP_RW skbs without calling
> virtio_transport_consume_skb_sent() to decrement vvs->bytes_unsent. Doesn't
> this leak vvs->bytes_unsent and cause vsock_linger() on close() to block until
> sk_lingertime expires, similar to the issue fixed by commit 002541ef650b
> ("vsock: Do not allow signal/timeout on established sockets")?
> 
> And if no signal or timeout is pending, vsock_connect() exits the wait loop,
> consumes sk->sk_err via sock_error(sk), calls vsock_connect_close(sock), and
> returns -ECONNRESET while leaving sock->state as SS_CONNECTED with sk->sk_err
> cleared to 0.
> 
> Should vsock_g2h_reset_unreachable() set sk->sk_state = TCP_CLOSING like
> virtio_transport_do_close(), or should vsock_connect() also check for
> sock->state == SS_CONNECTED after schedule_timeout()?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com?part=4

This is legit and thinking I'll move to the TCP_CLOSING solution.

Best,
Bobby
