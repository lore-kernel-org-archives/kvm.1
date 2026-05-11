Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCDE268690
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490661; cv=none; b=Lz88wkmPp9ZAABytrHTJDYalBXAz5crcxkklAi8sNpXW+OqgI5tcAHT8imMZ2A5AkRTMxNPt6QpdLj6CC4nI3NK5976Iss1rdEkpPc0OBXNp4Mc1ab8MrbtppWW3NAmrO98okK7yIy7jY50Vv2Rd6pcqwwbglFKKT3vbGP/ld2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490661; c=relaxed/simple;
	bh=NOVPw0sRFmhs/549yezkhu2bnfPqQ2AHmr7i3bUMSWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTEDUXWAeucjZoRVZkItyfgpk7Os3lBsj2Nv86yGO6OAxNVQ/9m2EqwzHnajSi0Gpse5ktmdht/0uHSIZzIVtTOCvfGhbkxQCACbrphzizm9IMhqPeQFc0nXJByVh6p500S7eDY9CeGeifJ1SCGHGuK7b/4CTwoSPbQMigj5dJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWkYLsRP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUyu9PCk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWkYLsRP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUyu9PCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GeXjhbPFcIE2xpoWydu6GqD8aKPwmV5ublK6KJ28nAc=;
	b=HWkYLsRPaoHz7KxJeITJVNyRa6E5WsVlc16ZlutllRZbbuFHen+MVD8JttVhcgSGaRIsiD
	oRldV0qbPj6xpMgD2PqQX1yaQ36fidiEJWTB28Th7UTondJ9eIpN+dJDJTK1UM2+lBlNO2
	0Ses0Vlabd6F+Vr88KrhAH0YGSTXECM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-2KKtsCV1PKO1yGTLMmpFWQ-1; Mon, 11 May 2026 05:10:57 -0400
X-MC-Unique: 2KKtsCV1PKO1yGTLMmpFWQ-1
X-Mimecast-MFC-AGG-ID: 2KKtsCV1PKO1yGTLMmpFWQ_1778490656
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a5952c635so46989865e9.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778490656; x=1779095456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeXjhbPFcIE2xpoWydu6GqD8aKPwmV5ublK6KJ28nAc=;
        b=gUyu9PCkWd2lgQx96I+kGh1XC3gqZO9nAu+qbvim7zG6zlyQZW0FDmUBk9NdAH3f+a
         MOPpQ5c3gF/MHJSLeZmR4AispSwWGP90lRx70L0T11x1sttkhRCMwEJXkEsyPBad7si1
         hCUo2MAHhcYjeFohSkq5KRXd/xuM2nujga7ee6jZs8y+9ozs+AN7o08KxBKWI8IS6k8Z
         YOTt+sMCGgBCNPUqmgvl2VrvikQfPiQEWLwf8+g3Rk7h58J1gaXmbGB7+DRpq8U3kcoh
         xv4mm2PZ13z7fIsZHMrmLsVqIMjs+w6fO6NDGn2jtKzmABKC0Q2DD/Jp52MxrMlJifh8
         om9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490656; x=1779095456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeXjhbPFcIE2xpoWydu6GqD8aKPwmV5ublK6KJ28nAc=;
        b=PbROKMdACexG1MLRR+H0fFEKksAys1dTD8LA4fr4KgkR6R/FYCttlmPGPua/nSq+x3
         hqcGM2fXI4bScXnaTJY/0hLS4fPMnca/uLbXM7YclI3LsZDpX6DS9Bux+5Pkd+TkUa6U
         nx7CsWOsPpAUyC+wjoicsIQGMVmNXsZhjDx2zvDbtFcJoFPIh0sEpBZQTJVeXgkn1UXK
         HijM2umfffZJnxbFCUw23Xy/tIHEaRPllZKj8iwZXXeQ+ENv7/q6Wx5LNzYE7IYwZPLG
         QSAq8ng0zB0MwR/QMejokTUpPgUQBz3SYIMFgOBBxD1HWU5BZ4HHsHJzwRuuCGZD15Hc
         YNoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TLrdcOi4t49vbrfEKcabsAHKeHq3Piwaf3FHH70rwX/WyDLDZ3GzywaqOG8gKG1KcRPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPlc1/5k1Te9GOeLHRZoc29NKm9bcAMQtU/2oZYfladArmFK4o
	pMBd1zXMXcdL0Ds38xZOVa00RUEVfUbnmpTCpBI+GH/xzKwHyknf8fgChpNtfTfPxXBq2/PA6RY
	mtmUMb4BKv02eFjOcba2lIxfu1HIZGrfIt++pTQIy09yxKpZjE2Q0WRSEtGP+ZXO6
X-Gm-Gg: Acq92OFQX5nIwGmjQpVJhXmb9x9oGpHog0dxeIPWynpaHTWwEVZ9m0ZSgkVtFs1NgSQ
	lu26fcs8s+89MEAYJNORYKq3ySBMRCLHoWEJBuR/VMP5b47nep8/Xm+oJOUXEc8bLZIxXOupjeS
	yBExAjOoiJQ4/MQidhTff7t5iM0iqsj+zCMAPyTgMpwIXm16R/dplcH+Us4xpYEUkiPWhY1eS9G
	EFXR4ZPuiRNGdb5UBEY3xBTx5wbqIvAg2hk6FXvdjDotocCH6m4vJ2E0f1ckDSYO20z8/tgwgKP
	fiqo0vJyj/A/nyEEW18dywRm2/10+j0sSaUoPyIy+4K1lMUGMgsf149fYm3VpYE5UC2p2p7pwcX
	Azr2IkFfqo8X6M3ZCmvOnyTM5V1KGi6Odtxf3qQRc
X-Received: by 2002:a05:600c:628d:b0:48e:82b4:b54 with SMTP id 5b1f17b1804b1-48e82b40ba4mr52289665e9.23.1778490655515;
        Mon, 11 May 2026 02:10:55 -0700 (PDT)
X-Received: by 2002:a05:600c:628d:b0:48e:82b4:b54 with SMTP id 5b1f17b1804b1-48e82b40ba4mr52288725e9.23.1778490654837;
        Mon, 11 May 2026 02:10:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db09cb6sm58109535e9.22.2026.05.11.02.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:10:54 -0700 (PDT)
Date: Mon, 11 May 2026 05:10:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v12 0/4] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
Message-ID: <20260511051037-mutt-send-email-mst@kernel.org>
References: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>

On Sun, May 10, 2026 at 05:15:25PM +0200, Simon Schippers wrote:
> This patch series deals with tun/tap & vhost-net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
> patch series, the associated netdev queue is stopped - but only when a
> qdisc is attached. If no qdisc is present the existing behavior is
> preserved. The XDP transmit path is not affected. This patch series
> touches tun/tap and vhost-net, as they share common logic and must be
> updated together. Modifying only one of them would break the other.
> 
> By applying proper backpressure, this change allows the connected qdisc to 
> operate correctly, as reported in [1], and significantly improves
> performance in real-world scenarios, as demonstrated in our paper [2]. For 
> example, we observed a 36% TCP throughput improvement for an OpenVPN 
> connection between Germany and the USA.
> 
> Synthetic pktgen benchmarks indicate a slight regression, and packet
> loss is reduced to near zero. Pktgen benchmarks are provided per commit,
> with the final commit showing the overall performance.

at v12, time to merge this.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Thanks!
> 
> [1] Link: https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
> [2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> 
> ---
> Changelog:
> v12:
> Patch 1: 
> - Revert tun_queue_purge() to plain ptr_ring_consume() and instead
>   explicitly wake the queue in __tun_detach() for the ntfile taking
>   over the queue slot (if its ring is empty).
> - Inlined tun_reset_cons_cnt(), because only tun_attach() uses it.
> 
> - Patches 2-4 and cover letter unchanged.
> - Compiled and short pktgen test.
> 
> v11:
> - Renamed __ptr_ring_produce_peek() to __ptr_ring_check_produce()
>   (Sashiko)
> - Add return code -EINVAL to __ptr_ring_check_produce() which lets
>   tun_net_xmit() stop the queue only on -ENOSPC. (MST)
> - Resolve race on tfile->queue_index by locking tx_ring.consumer_lock
>   in __tun_detach(). (Sashiko)
> - Wake the queue in tun_queue_resize() to avoid possible stalls.
> - Other minor adjustments & reran the benchmarks.
> 
> v10: https://lore.kernel.org/netdev/20260506141033.180450-1-simon.schippers@tu-dortmund.de/
> - Changed the term "Transmitted" to "Received" in the benchmarks,
>   as correctly pointed out by MST, and reran the benchmarks.
> 
> Addressed the Sashiko AI review:
> - Avoid a data race on tfile->cons_cnt by always locking.
> - Correctly count the number of consumed packets for vhost-net.
> - Corrected a typo in the commit message of commit 3.
> - Added a missing barrier on the consumer side.
> --> The barriers now follow the "store buffering" principle.
> - No longer return NETDEV_TX_BUSY at all, because it is unsafe.
> --> Result: There are still a few drops with multiple senders, which
>             would be avoided by disabling LLTX.
> 
> V9: https://lore.kernel.org/netdev/20260428123859.19578-1-simon.schippers@tu-dortmund.de/
> - Addressed minor nit by MST in patches 1 and 2.
> - Rebased patch 3 because of commit d748047
>   ("ptr_ring: disable KCSAN warnings").
> - Documented the pair of the smp_mb__after_atomic() in tun_net_xmit()
>   with tun_ring_consume().
>   --> It simply pairs with the test_and_clear_bit() inside of
>       netif_wake_subqueue().
> - Use 1 ptr_ring consumer spinlock instead of 2.
> - Ran pktgen benchmarks with pg_set SHARED for 50 iterations on
>   latest kernel
>   --> No significant performance difference noticed
> 
> V8: https://lore.kernel.org/netdev/20260312130639.138988-1-simon.schippers@tu-dortmund.de/
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
> - Switch to an approach similar to veth (excluding the recently fixed 
> variant), as suggested by MST, with minor adjustments discussed in V6
> - Rename the cover-letter title
> - Add multithreaded pktgen and iperf3 benchmarks, as suggested by Jason 
> Wang
> - Rework __ptr_ring_consume_created_space() so it can also be used after 
> batched consume
> 
> ...
> 
> ---
> 
> Simon Schippers (4):
>   tun/tap: add ptr_ring consume helper with netdev queue wakeup
>   vhost-net: wake queue of tun/tap after ptr_ring consume
>   ptr_ring: move free-space check into separate helper
>   tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
> 
>  drivers/net/tun.c        | 109 ++++++++++++++++++++++++++++++++++++---
>  drivers/vhost/net.c      |  21 +++++---
>  include/linux/if_tun.h   |   3 ++
>  include/linux/ptr_ring.h |  20 ++++++-
>  4 files changed, 139 insertions(+), 14 deletions(-)
> 
> -- 
> 2.43.0

