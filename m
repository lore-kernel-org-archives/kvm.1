Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7B34CFD1
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323751; cv=none; b=rVRhDDo1Zy1FO5isfMStQSL4ZX28I2EPhL4mlkBcPkBJdOsCMwbk0P3Fu3RQ6cxFzUSh7EQXwJB9jTO+T/xslO5U0HU1FKugPUKr2ma8gOAqnmIROXR/ith55CvK6b5tkR1klEq8SEkbvM++0qJ3Qkk638CP0dutHSxBly+W9Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323751; c=relaxed/simple;
	bh=pDwcH5sWvmvLtMK0Rq/VsVo4eeCmzGZVcSwBbbkMDNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn0LL/QZjMoydvV9BcuPIPTPU5ba3Faz5cQmTz4unzCAn6rS5/d6YAP9GKwkdk/TILvKVbiob1wNV6WPz0NVvURw1x/CDEhJiv2qypjLXMlNK9vmo5+v+Z6e7soFu51INlHH11Jo7WYr0XSaGyPkijWgQxkYQQazeJzWZn7vIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/xeD6dC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sWYHCHud; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/xeD6dC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sWYHCHud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773323749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2e1MRF6EEdhdpvTu+HbMn5gU38H7GgDFPk5x0iwlRg=;
	b=G/xeD6dCF/g5yUjx/z/Kzgf+76AqYJPSbKJD2wkR/YySz4TzGUL5vl38QxEDunQd/Sq7yG
	hKIZYIndObj/DxniflRO+KWQ2E6iCYQhZd31k/dr6WvB3x6nLeu6H/2PI47KIJcT+/cbYU
	DRKz0eruf+9XpR+1etKDzk5cKpgsYnk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-Tw67XMUrMPi4-ghhXPU4cQ-1; Thu, 12 Mar 2026 09:55:48 -0400
X-MC-Unique: Tw67XMUrMPi4-ghhXPU4cQ-1
X-Mimecast-MFC-AGG-ID: Tw67XMUrMPi4-ghhXPU4cQ_1773323744
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853b00f9f5so9620825e9.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773323744; x=1773928544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2e1MRF6EEdhdpvTu+HbMn5gU38H7GgDFPk5x0iwlRg=;
        b=sWYHCHud1jaif1GW2pwht+y4LF8CTwkqhdISMV1NuiJQ6kzksiaZspyyyPreT28BRu
         H7zhcSwULS0jYl/abgbIKvmTkkIPAvJraS8X8Wr57Khlp4zmowkoS5bhWYYWV7PcxBuU
         IzvVRGWYYGJt1GRroB3YYJ6oYd3nJqCw8MGzPnUzf2lnd7qbCanF3OcdzLFAZsXny/g8
         gKqiOsEdcPH5yyscqbgaUzlV73S3RJK9ez7mdQa5wj1iO7h/zR0qQGbm0tprhv/sg/gj
         RGDbP3uB5KoK8zzf7M50Doo2QoQcwzbDMy7Zo084G/aOUceZ/P35zLjfUN4mSECX5Sor
         6qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323744; x=1773928544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2e1MRF6EEdhdpvTu+HbMn5gU38H7GgDFPk5x0iwlRg=;
        b=txe0Fb3czAIv3LIES+vZ2i0zJ1TpGLisXxudNyhehxOZAMO+VvLS3qP1twi6OHhaAe
         n0ZfPXFf/QV9dIK59G3PUvGTNAQNzyS+pW9GF1m/IzAWUX8XjbmO3snVaSPBGXfNne6Y
         UqeXN4UYZtEGT69F7ZAwEuku1/fUL6tVgnDDd30aXUZ2MCgpScuFyiQCc8fDYmuxyvqu
         X1ALKDlkiN1cllx6Klj3kcC0gjtBjqlUSEUNg3nSyFQ9mFB5pmfJOG5I5mKkNDg/1rcp
         V8uhyaXy+bpncof25fgsuuo5sQqu9a8odqd3fTV1LqfmQ0YWyiK9T9iqvr08XcGSCW6B
         Qw0w==
X-Forwarded-Encrypted: i=1; AJvYcCWbpjkAp5VBZUyBFA/DjD7ZwR0deD0BQvFS876U+NWoPr5jJW69BOkwf7c1IbIFU0buShM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd6Bmws9QEsQwf6RuH8OBJz6j0JjgBK2aPHH+8CUUnm5R8itrZ
	/893K6QoTCiXkr7KlnHZYwSHqq3B6YeNevhvMVEjIw7nQMfPEa3XgcAx353yqob6GVZ6wskdoha
	tgmDDWTRqHBAm5cjny5IsAo4jKVhcRbU2ODFEQgLFO1hznQ4MJ/cALA==
X-Gm-Gg: ATEYQzzp1lXL3lBx/kfTweUqGz+5TxVF7a4l6RSZzxOSmwIHz3Xo6oITjaAQ4W4lwwX
	jZgNmnd2UROgM0ecLbJhOnzKHRvox2hBK+DIVcDaCEp4vvgFc3WINqgvfKSKMavJC2vyR+cAXSF
	dLi+2Mfl0h2MQyWXfsDWlkxMx3JrjdNtzopMBwRdKR+QiEpu551+PsmRa6fLD5h/y04aWCnU7Hl
	qFY5X57yzjIWpu75nYDnV1XHa6czt0fsjqwClXJ9K/t6KOso09zafZSlQZgro2YxooQpOE2eoCb
	0pswOcpVbVXSX5sqCb0fk9xH+eHUq0VNf1vash0BHpoe8sziovntFNuZ7RaiagSQF/3B6EtJMvz
	02nbxZydqIhXYrTNiTsPkksbrdTfswOpInCqj6js+ThgW9g==
X-Received: by 2002:a05:600c:8b45:b0:485:4388:3496 with SMTP id 5b1f17b1804b1-4854b10f9bfmr97333285e9.11.1773323743537;
        Thu, 12 Mar 2026 06:55:43 -0700 (PDT)
X-Received: by 2002:a05:600c:8b45:b0:485:4388:3496 with SMTP id 5b1f17b1804b1-4854b10f9bfmr97332345e9.11.1773323742923;
        Thu, 12 Mar 2026 06:55:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f406sm226604625e9.13.2026.03.12.06.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:55:42 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:55:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 0/4] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
Message-ID: <20260312095457-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>

On Thu, Mar 12, 2026 at 02:06:35PM +0100, Simon Schippers wrote:
> This patch series deals with tun/tap & vhost-net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
> patch series, the associated netdev queue is stopped - but only when a
> qdisc is attached. If no qdisc is present the existing behavior is
> preserved. This patch series touches tun/tap and vhost-net, as they
> share common logic and must be updated together. Modifying only one of
> them would break the other.
> 
> By applying proper backpressure, this change allows the connected qdisc to 
> operate correctly, as reported in [1], and significantly improves
> performance in real-world scenarios, as demonstrated in our paper [2]. For 
> example, we observed a 36% TCP throughput improvement for an OpenVPN 
> connection between Germany and the USA.
> 
> Synthetic pktgen benchmarks indicate a slight regression.
> Pktgen benchmarks are provided per commit, with the final commit showing
> the overall performance.
> 
> Thanks!

I posted a minor nit on patch 2.

Otherwise LGTM:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

thanks for the work!


> [1] Link: https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
> [2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> [3] Link: https://lore.kernel.org/r/174549940981.608169.4363875844729313831.stgit@firesoul
> [4] Link: https://lore.kernel.org/r/176295323282.307447.14790015927673763094.stgit@firesoul
> 
> ---
> Changelog:
> V8:
> - Drop code changes in drivers/net/tap.c; The code there deals with
>   ipvtap/macvtap which are unrelated to the goal of this patch series
>   and I did not realize that before
> -> Greatly simplified logic, 4 instead of 9 commits
> -> No more duplicated logics and distinction in vhost required
> - Only wake after the queue stopped and half of the ring was consumed
>   as suggested by MST
> -> Performance improvements for TAP, but still slightly slower
> - Better benchmarking with pinned threads, XDP drop program for
>   tap+vhost-net and disabling CPU mitigations (and newer Ryzen 5 5600X
>   processor) as suggested by Jason Wang
> 
> V7: https://lore.kernel.org/netdev/20260107210448.37851-1-simon.schippers@tu-dortmund.de/
> - Switch to an approach similar to veth [3] (excluding the recently fixed 
> variant [4]), as suggested by MST, with minor adjustments discussed in V6
> - Rename the cover-letter title
> - Add multithreaded pktgen and iperf3 benchmarks, as suggested by Jason 
> Wang
> - Rework __ptr_ring_consume_created_space() so it can also be used after 
> batched consume
> 
> V6: https://lore.kernel.org/netdev/20251120152914.1127975-1-simon.schippers@tu-dortmund.de/
> General:
> - Major adjustments to the descriptions. Special thanks to Jon Kohler!
> - Fix git bisect by moving most logic into dedicated functions and only 
> start using them in patch 7.
> - Moved the main logic of the coupled producer and consumer into a single 
> patch to avoid a chicken-and-egg dependency between commits :-)
> - Rebased to 6.18-rc5 and ran benchmarks again that now also include lost 
> packets (previously I missed a 0, so all benchmark results were higher by 
> factor 10...).
> - Also include the benchmark in patch 7.
> 
> Producer:
> - Move logic into the new helper tun_ring_produce()
> - Added a smp_rmb() paired with the consumer, ensuring freed space of the 
> consumer is visible
> - Assume that ptr_ring is not full when __ptr_ring_full_next() is called
> 
> Consumer:
> - Use an unpaired smp_rmb() instead of barrier() to ensure that the 
> netdev_tx_queue_stopped() call completes before discarding
> - Also wake the netdev queue if it was stopped before discarding and then 
> becomes empty
> -> Fixes race with producer as identified by MST in V5
> -> Waking the netdev queues upon resize is not required anymore
> - Use __ptr_ring_consume_created_space() instead of messing with ptr_ring 
> internals
> -> Batched consume now just calls 
> __tun_ring_consume()/__tap_ring_consume() in a loop
> - Added an smp_wmb() before waking the netdev queue which is paired with 
> the smp_rmb() discussed above
> 
> V5: https://lore.kernel.org/netdev/20250922221553.47802-1-simon.schippers@tu-dortmund.de/T/#u
> - Stop the netdev queue prior to producing the final fitting ptr_ring entry
> -> Ensures the consumer has the latest netdev queue state, making it safe 
> to wake the queue
> -> Resolves an issue in vhost-net where the netdev queue could remain 
> stopped despite being empty
> -> For TUN/TAP, the netdev queue no longer needs to be woken in the 
> blocking loop
> -> Introduces new helpers __ptr_ring_full_next and 
> __ptr_ring_will_invalidate for this purpose
> - vhost-net now uses wrappers of TUN/TAP for ptr_ring consumption rather 
> than maintaining its own rx_ring pointer
> 
> V4: https://lore.kernel.org/netdev/20250902080957.47265-1-simon.schippers@tu-dortmund.de/T/#u
> - Target net-next instead of net
> - Changed to patch series instead of single patch
> - Changed to new title from old title
> "TUN/TAP: Improving throughput and latency by avoiding SKB drops"
> - Wake netdev queue with new helpers wake_netdev_queue when there is any 
> spare capacity in the ptr_ring instead of waiting for it to be empty
> - Use tun_file instead of tun_struct in tun_ring_recv as a more consistent 
> logic
> - Use smp_wmb() and smp_rmb() barrier pair, which avoids any packet drops 
> that happened rarely before
> - Use safer logic for vhost-net using RCU read locks to access TUN/TAP data
> 
> V3: https://lore.kernel.org/netdev/20250825211832.84901-1-simon.schippers@tu-dortmund.de/T/#u
> - Added support for TAP and TAP+vhost-net.
> 
> V2: https://lore.kernel.org/netdev/20250811220430.14063-1-simon.schippers@tu-dortmund.de/T/#u
> - Removed NETDEV_TX_BUSY return case in tun_net_xmit and removed 
> unnecessary netif_tx_wake_queue in tun_ring_recv.
> 
> V1: https://lore.kernel.org/netdev/20250808153721.261334-1-simon.schippers@tu-dortmund.de/T/#u
> ---
> 
> Simon Schippers (4):
>   tun/tap: add ptr_ring consume helper with netdev queue wakeup
>   vhost-net: wake queue of tun/tap after ptr_ring consume
>   ptr_ring: move free-space check into separate helper
>   tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
> 
>  drivers/net/tun.c        | 91 +++++++++++++++++++++++++++++++++++++---
>  drivers/vhost/net.c      | 15 +++++--
>  include/linux/if_tun.h   |  3 ++
>  include/linux/ptr_ring.h | 14 ++++++-
>  4 files changed, 111 insertions(+), 12 deletions(-)
> 
> -- 
> 2.43.0

