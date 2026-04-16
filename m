Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D2837E2FF
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336724; cv=none; b=eeeeiqac4DjPf+AQp0lgEJ0czTqVNLHMV3A/oDXbT3LwukidQcht1Ix4WMKHz5o72034xRcN+8JOY0eDWByYBnDX7ssSypKnsD6vmUHz/MAsHBGsL+9pLhNm5C5yzy68lSkjfH5S8oSSAvCUV7jSts77GDwvYQvHq0zoKn7Xc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336724; c=relaxed/simple;
	bh=EixB+VBYELB9QZou2WcR2YRGdtQyBm7qn3tnBBWJdDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTL5V6Ny/YSdaFIiGpQP7bVGJS0froRSIv9sw/GZIkJGzeszfz4awPo7BmtpLSVRdEWCyv/7M7d92uDpoECXvp9XSj3HLzgGz6RQaRiAI/Q4pvGlGeI+UwPgx+ZvNzF888LoaYvQdhCUsXx7vjNb6pTDjYPK2SSGhvOGAUUZ45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNQ5dx8c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9pDKXmz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNQ5dx8c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9pDKXmz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776336722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWWOQAJEN/95l4X8m42iXJycRGuqxRmfK0Cq2b139G8=;
	b=FNQ5dx8c6ErdBngsENolYzOejj3f9uG9sKgk3zt7bIulZQY1JSqBSIMxpahmBU2QlCQAkh
	jQ6BlwsuA0GJCZ+cW7KXw420e/C97XJ60Nne9wdIH3d7ibJhP4gy0OSDrECpc/UEJI3+sn
	ff/PVMftux6wq9WTk9lqpkApUhOwGgk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-TE8Zm-oaMvK9eM2OlNxqXA-1; Thu, 16 Apr 2026 06:52:00 -0400
X-MC-Unique: TE8Zm-oaMvK9eM2OlNxqXA-1
X-Mimecast-MFC-AGG-ID: TE8Zm-oaMvK9eM2OlNxqXA_1776336720
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d03db814eso8304575f8f.2
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776336720; x=1776941520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWWOQAJEN/95l4X8m42iXJycRGuqxRmfK0Cq2b139G8=;
        b=b9pDKXmzU8odCvvbZSbGqpiOCJMohW8le3fF/j421w9JJdAvbReL2/DchM/ojolJy7
         96bOQgabS810Md2H7xmtl0mQo6CmBiI8pJzCwNBkTgpIfm0gNM6rrx77wEBYXGpaqHdI
         +mL2dFovR5dYttWpADpZgjUK6YLLOhe5L2xyaDIsiO+B4hQOvv2n76fTOXUi+DlEovqB
         0DUHH61W9gQYiLP89+lES+4fKxT5+Z0Ebv3mxE/s90sIu83Hnwe9/v3YbUkAr/ilcqm4
         HQqI4qVSpaKblX61RjVVXi2TJh+sClnDlb8uFqhk4PnK8OSR/ys4k7DijfcrqR8UbOdw
         lVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776336720; x=1776941520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWWOQAJEN/95l4X8m42iXJycRGuqxRmfK0Cq2b139G8=;
        b=LNC1yY0yhzQderMiDIqOKl3UgzrgYJcreQdj6eyQ83Puba88sotGZX1SbzUoUCC2Y5
         NE9aA1YPL99gZnTMEicnnoPXDoKR5Bwdu7rph9GSPlArG22Lw0/a96NJbwJzJMhp2r5r
         5kT0+qGiWVF3BBjoGNVd7sCxwyO8DzRepgS2TLoAnQjQMSVQYSuId4IYR8nDABN3MAO8
         2UB7qQT+IbEwsMKUaGX6USMzfAWo+fGSAdysAxdY8ifeF8W9+95MYL+N+CSGNShIwQwo
         wU6vsko//Hiqi+tXZKSeeRe+HdxTuVx4v3Go4flZAknlz7GOpqjHNuyXTzI1uwADlaLB
         qmBg==
X-Forwarded-Encrypted: i=1; AFNElJ+LUKjsdip/4ZP5V8Xr3M08b8Emm1GdlWPnpGnYwKiOYZB74/RqyQa7dCfbNnS7p3DfvjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxMo3XXARoRa2vJFsZgRW2AVhJzxrCGs7Yk79CxKzVa1N5+AZX
	As6pEU82rjG7lLOnS7ExZ1dTW7DWop4j8zkjqBF+Sk458P03RvOdVxI6pdtxiHe1lSSNWcFh4DR
	6OZCBDnWSRRMXb6HM7zHlR/xVDb+zqOKRwPq1irO2WMnSDAQA6E+Tew==
X-Gm-Gg: AeBDieuYMd7VS23i4fTgYKxtUY9TCSVUlyBd9e6OqLjnqiiOd4tjS4mjFQFu0HSMz3e
	OqHgQrYzlFLTo/6BSdJe8gDBWdA3KEKOCMSp4j/FPO9TsC/FL40atWuGGNCQ4qEHNx27W3jT/hG
	9eK3z/s8Ujow4l1gzV+GemPdxaQ7xW5PhY50BcO3IgUegFbBCzoy9rmTFy4IN7sAizxnWVMIzsk
	G5s2hqBgZPpy4qsvRp78YecJ+eSyMiHYZG4Lc/eOpNvsB98kVZVyeYsSBH1QRLikkd5Xem1khF/
	F5SOrQIqB3qVNBkutk6OiBYkuMCXUkP0ye2dwdKT0F/HdwOz2MINQOu3i6IZ3a7vgxa+v8VHW4u
	Jjnnl0JjHiN4v1T6u9Zs4XDopNyFxBOfEbvbislgSSYE=
X-Received: by 2002:a05:600c:c08b:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-488d68867a0mr252350555e9.22.1776336719541;
        Thu, 16 Apr 2026 03:51:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c08b:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-488d68867a0mr252350285e9.22.1776336718976;
        Thu, 16 Apr 2026 03:51:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818d70sm73936565e9.4.2026.04.16.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 03:51:58 -0700 (PDT)
Date: Thu, 16 Apr 2026 06:51:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
Message-ID: <20260416065132-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-5-simon.schippers@tu-dortmund.de>
 <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
 <0908392d-6314-4141-b908-6c9a880ba0a4@tu-dortmund.de>
 <cda710f8-033a-4772-b5ce-a2cfddf42bea@tu-dortmund.de>
 <CACGkMEuLqxnz=GtdKp3-u0egkGT_eZUgBBwvvtHcgAYpLJv-UA@mail.gmail.com>
 <3d3274b4-f274-4cf9-9d0f-989d05148604@tu-dortmund.de>
 <CACGkMEsUag4zNZG+aYipHv_PirbKb_rs7DzSOr-NF8ckhUaJOQ@mail.gmail.com>
 <b9d84d88-46d5-4fd3-a5b2-d914f54766f6@tu-dortmund.de>
 <73033bfc-4da3-4057-9480-bd977a66ecef@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73033bfc-4da3-4057-9480-bd977a66ecef@tu-dortmund.de>

On Thu, Apr 16, 2026 at 10:54:45AM +0200, Simon Schippers wrote:
> To summarize the discussion from my POV:
> 
> Open point: __ptr_ring_zero_tail() is only called after
>             consuming ring.batch elements.
> 1) Consumer wakes up the producer but the slot is not cleaned.
> --> I disagree, the consumer only wakes after consuming ring.size/2.
>     Then __ptr_ring_zero_tail() was called at least once.
> 2) Producer is woken up but see the ring is full, so it need to
>    drop the packet.
> --> I disagree, because then NETDEV_TX_BUSY is returned. This is
>     noticeable as qdisc requeue and only happens very rarely.
> 
> Points I will address:
> - Minor nit on patch 2 by MST.
> - Rebase patch 3 because of commit d748047
>   ("ptr_ring: disable KCSAN warnings").
> - Document the pair of the smp_mb__after_atomic() in tun_net_xmit
>   with tun_ring_consume().
> - Use 1 ptr_ring spinlock instead of 2 (currently used for consume
>   and empty check), not sure how to implement it pretty rn.
> - Run pktgen benchmarks with pg_set SHARED.

Thanks! The plan makes sense to me.

-- 
MST

