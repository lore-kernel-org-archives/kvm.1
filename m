Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2532B10E
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710199; cv=none; b=LwRa9mhng3sNFuLvUGlxq9n+89aQc7qazoItjrezdMQJPL0OkzdRdPlfkEXyGtMvopm5z2qbMs8G4TIUasogkh6ybaVGX7eLlrbIuqdqw27LlULT6801OaHMDF6ic9MbqpbLk47YhhAE2ODSgoHB3aqYd8CnjpP/ycoA2dCJc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710199; c=relaxed/simple;
	bh=PjgjwZnGgTn6iqnEiUJ3bPEVMifERR8pCitafp8p2xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFg4kXSBRThDVjvCQAPlL+YEgZnZrsYowi57KqUK5yyF/6d2MH/O5uLg5t4SK62oyxKLSEg38tfK73GuERB7pklK5cTkozu+PF6xFxZ6eaqt9W+IhS6dd9GAu/EmrYEG6ED0tQ604NTLO2wnLw3FQa0xSQNCuHCD0lo3BPQbmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyfKtwFJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxKBrwKZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyfKtwFJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxKBrwKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786710195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdXWuErOvyDV9Y8ztCqoO/f6xuxZcnsGekDRRKOGqDQ=;
	b=NyfKtwFJg40KApYJl7HMc5X/BHYsCfipWWJbE7G7rfTniXhpV3Nc6eTpW4ZuRC82N5pjW4
	7A7BqGs5QBltHw9v7MohdKA1sku94li4uveIlVNoG6HJcML18GOgSnHYVNCy6MhphoHq+L
	VaGxxw/XbM75XpoSmIFFnN349SGHZjQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-RQlnl7fuO2moX2SOlG_NgA-1; Fri, 14 Aug 2026 08:23:14 -0400
X-MC-Unique: RQlnl7fuO2moX2SOlG_NgA-1
X-Mimecast-MFC-AGG-ID: RQlnl7fuO2moX2SOlG_NgA_1786710193
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4957287363bso5676875e9.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786710193; x=1787314993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PdXWuErOvyDV9Y8ztCqoO/f6xuxZcnsGekDRRKOGqDQ=;
        b=HxKBrwKZhHhN+M0pEN33Tm9M5ZWp2DKrTB2+8kCkCGA69bwlcPXpEzdxRilumJdL6s
         tta5DpD0/oa+GZI6kKLeXYskl8homjPmuzy/wm/rhme2n//Ma/KO+kT8H22haVPtDa2x
         rfBGXcrgBRpvCinACPaGy/Otc4chPImQd43x5zWopyjTVKaRL26+sY9tViWYnmfqFPnF
         jCWaGbv85s56uCnyrTAzCj/pxeRJEdUvyKL5JRo+53TxZEonkXZdwFluPRpAiAykM9G2
         5iRYSGArzxZMbGD7uyj9cSb2OhlUc7B7azLW+1D4xhqgDYGh8nX5iEotcr6aFyuaz3IQ
         YY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786710193; x=1787314993;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdXWuErOvyDV9Y8ztCqoO/f6xuxZcnsGekDRRKOGqDQ=;
        b=e+ODWfe7F3WdkFBcG511IkMcSCOIqSTYbrlEzx8ejqbhxYrLhjBSRdZMtoOfbkvRhp
         KwRlpCjZ/wivkgp3ug4Sr0O6hwIe6okeoITp1mpP+dDx7v4RP6ix2Fp3Fnfd2CoMnz4P
         n0THlxeGJnLSM0+IIxsscPTwSGGXHT0rZ6cMhbQwhI0oK1emWquJdeckXYa8WAMh7wtA
         tBHkVLrYQwRvpPMepA2nPj3gaQS1J8I93FXlpezqoRB0iSsxpfoZB/PV8zGatgET/VJK
         G6bvoKxZNnKl/t8pcq31cosSZXIWqg4jxuBeKKy/+3Ma0c7pglGjzF2fA0PDHBros7mK
         Ry4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrHKmJuwXCVioGQFqD4WJurlGvYxgiYHfZ3oEmLGXn4WdqMmYqMXMhFtfmzJJOJT5R6KzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIU0+maueDwQz7Lu8K7J7byTuMDC8McK9olW95OYS4A1ENeLfy
	rqoDsVTO3wzMK8Mp+BgJrhjuYVASmqeoHQ+DoCfHmaiHUH70LRckl6Gpc6CPHuY6RXjs5BcVdwz
	6Z6lW0V/thzc+kV3+rqK1IyZSj8FFe5F/VHDAHtubRowePG+PCw/Cyw==
X-Gm-Gg: AR+sD10xRG4WEJzzqedZMS3diZ9X8XQHMMvS156zZ8z2MXSwZ9USTDYLBtvBuBqW+Ds
	uGwtCjXYhDLw6V//JSrM28fLfjjt8EgHHL9JNq4+j2akkkP0yS4xi+Vku9uo2s9FAMWxcxcIgcl
	hmqVo2rNKRjM2gWaqphmiBF/bRRNAcHB9vr4hF7MFPoyAv2oCvJFlToxvGG+quSFd7bClaNRGEB
	ClkQDcSXBZX8Hes2JsnQB0m0eDHUyMVAov8DgVuwsgpzOcCyv6ROqZlViBoxGnhgG2urMYHOX+x
	cYP6uitdds8ZnjCFl5n0SVYY+KUc6s/lHF2mTC3vceCDFxHBLAuyVBeZ6peL1ve+8KEs62B5Kxl
	+855aL5pASdmDM3dsMjsB7RAAoerowkr2csqkcqaeuYpYtPH9fhdr
X-Received: by 2002:a05:600c:1d1e:b0:496:bbcb:b0bb with SMTP id 5b1f17b1804b1-49987992addmr59968675e9.18.1786710193298;
        Fri, 14 Aug 2026 05:23:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1e:b0:496:bbcb:b0bb with SMTP id 5b1f17b1804b1-49987992addmr59967975e9.18.1786710192832;
        Fri, 14 Aug 2026 05:23:12 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b27bfsm7763993f8f.23.2026.08.14.05.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:23:12 -0700 (PDT)
Date: Fri, 14 Aug 2026 14:23:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: validate packet source for connected
 sockets
Message-ID: <an7vDxDT-N6xi-3l@sgarzare-redhat>
References: <20260813121236.2328599-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260813121236.2328599-1-4ncienth@gmail.com>

On Thu, Aug 13, 2026 at 09:12:36PM +0900, Daehyeon Ko wrote:
>virtio_transport_recv_pkt() first looks up a socket using the full source
>and destination tuple.  If that misses, it falls back to a bound-socket
>lookup using only the destination address.  The fallback is needed for
>listening and connecting sockets, but it can also select an established
>socket that remains in the bound table.
>
>As a result, a packet from an unrelated source can be dispatched to a
>non-listening socket.  In TCP_SYN_SENT, a source-blind RESPONSE marks the
>selected socket established while retaining its original remote address.
>Subsequent RW packets can likewise be delivered through the
>destination-only fallback.
>
>This was reproduced with two capless processes under different UIDs.  The
>attacker discovered the victim tuple through unprivileged AF_VSOCK
>sock_diag and injected a chosen 16-byte payload into the victim established
>loopback socket.  The legitimate peer received none of those bytes.

I don't understand this, what it means? If the receiver doesn't receive
those injected bytes, should be fine, no?

>
>After taking the socket lock, verify that packets for non-listening sockets
>come from the peer stored in remote_addr.  Listening sockets continue to
>accept packets from any source.

IMO this description should be improved, it's quite hard to follow.
This is an idea IIUC the issue:

   virtio_transport_recv_pkt() looks up sockets in two steps: first by
   the full source and destination tuple in the connected table, then by
   destination only in the bound table. The fallback is needed for
   listening and connecting sockets, but it never validates the source
   address in the packet header. Since sockets remain in the bound table
   after connect(), a packet from any source can be dispatched to a
   non-listening socket.

   An unprivileged process can discover the target tuple through AF_VSOCK
   sock_diag (no capabilities required), send a forged RESPONSE to a
   TCP_SYN_SENT socket to establish the connection, and then inject
   arbitrary data through subsequent RW packets, all delivered via the
   destination-only fallback.

   After lock_sock(), verify that the packet source matches the
   remote_addr stored during connect().

>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Cc: stable@vger.kernel.org
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8becad812..f73e0406a 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1822,11 +1822,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>
> 	lock_sock(sk);
>
>-	/* Check if sk has been closed or assigned to another transport before
>-	 * lock_sock (note: listener sockets are not assigned to any transport)
>+	/* Check if sk has been closed, assigned to another transport, or if the
>+	 * packet is from a different peer than the one connected to sk.  These
>+	 * properties could have changed before lock_sock.  Listener sockets are
>+	 * not assigned to any transport and accept packets from any peer.

Please keeps changes minimal, why adding "These properties could have
changed before lock_sock." and changing the phrase related to listener
socket?

Also the new part is not clear IMO, we should explain why we are adding
this new check, not what we are doing which is clear looking at the
code.

IMO we should just add something like this (feel free to change it):

   Also verify the packet source: the bound-table fallback lookup
   matches by destination only, so a non-listening socket can be
   reached by a packet from an unrelated peer. Drop it unless the
   source matches the peer the socket is connecting or connected to.

> 	 */
> 	if (sock_flag(sk, SOCK_DONE) ||
>-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>+	    (sk->sk_state != TCP_LISTEN &&
>+	     (vsk->transport != &t->transport ||
>+	      !vsock_addr_equals_addr(&src, &vsk->remote_addr)))) {

Do we need to add the same check also in the VMCI transport?

Hyper-V seems different.

Thanks,
Stefano

> 		(void)virtio_transport_reset_no_sock(t, skb, net);
> 		release_sock(sk);
> 		sock_put(sk);
>
>base-commit: 9006c116dd111d457bf5d074990210f70a4ad2c8
>-- 
>2.54.0
>

