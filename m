Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00178375ADE
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220571; cv=none; b=ox8sLXfcqOP3wc5f7kxllAWMBqPUDPQXz2WxsUEtNVX1UDp5bSoRu6s0bwUYA0WYMMSVxZ4uoSlTJH/Qbq0WpAGGG1U6yqQCI3vqgwddDkI/0r5IPcUnJqQctMXnxQBS3NHADRhMShQ2RXJyINLhjcvBuRuLKPtpzB0oEFHHyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220571; c=relaxed/simple;
	bh=K5xtDAuyrMvBSiVkIb+d9ftD5LvUthW6cMj49rrgJho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4HTPhJK1RALEp2CQyuMnhw4jDaRc+3zMwV4ONBsBQ0h7XYiJTtEKJJD3l+/xhH3nnqLREXsBvKQ92sD/2Wbl0TJoB4VSrZEFjH/9LKwzdP5dM4fle3fsdpEEVoDsrj7p5sJw1dV005ETbCrDV2+etcMSQPVBWNA1+Tx6Uhfs54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhInWByL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U46N8jUI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhInWByL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U46N8jUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778220560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GeECdFhE1e2rNXT3Sj2OPEv03eYYs8feiSdikU8nZxQ=;
	b=YhInWByLwfXvAxFPgnUAyR/GvQFS5Gw2zvdmGhKG3KudwezW2u8tPvDiaRKvWY/HAkkynl
	4nPNRMZbNk6ZCXJInkwmU2aBuCUgCJoRFZ2On9MnkxHaJFU+E3vQkJzvp9+dYi6enI1XMe
	qlpTjutVIJCAxmpP7CdVyDXEAeF+efU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-AF1FZqXUNxudxUc4h5rWcw-1; Fri, 08 May 2026 02:09:17 -0400
X-MC-Unique: AF1FZqXUNxudxUc4h5rWcw-1
X-Mimecast-MFC-AGG-ID: AF1FZqXUNxudxUc4h5rWcw_1778220556
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so7779615e9.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778220555; x=1778825355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeECdFhE1e2rNXT3Sj2OPEv03eYYs8feiSdikU8nZxQ=;
        b=U46N8jUIL2Cck8nZyo4+AqV7u/mUEf2njpwAqTYFZ1yGb+ea6RmTsFh9Ds+f7LTcXB
         VQ0efQRGRUFfvzS57B9FTcTx/0f6BgOA7yUiEu6obEF2s+EWKvOKuT6lsC7N0d0oMnqx
         0OcLArOvbRqE4um+7QW/HrY1AEIYC2Br8CkHqChEJT4RvjnlYaDTZqyXy3QAQA46lp7C
         6pdYn5DmVzZn8ETssgO2XrVkgaoZQW0wJfEeB5vviu+lHT/TOPUMnzI/9evE+OA+Lbml
         kUj5qjK/k8QEoq02oS5i/kJSJ76kjO9LZr4H0PE8n7lKT2ZTjjU3897k6VI97HTAEwIt
         8TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220555; x=1778825355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeECdFhE1e2rNXT3Sj2OPEv03eYYs8feiSdikU8nZxQ=;
        b=YZnycfj+YFdomY4nH3yaC+IksCkcmzgtzVZ42js2+mPPLNXqVI+fJ5nUb7tDdBKAvE
         q2ionUiNJ/vBIeyzKgRUeMRvIS6sASzseGTHOPnJbSdYMekxBxhHXDNxwezzUDUxqlXV
         FJ2LAOzQ03ZKdhEKUW3X5+IPuC6Lwv546mr3mDmFQCb0+ZqmPeUgxImoVyvMTH2SrR58
         ZB0XDML9JfWxWt4gOMx9LxtCAV7c6k64N5152zlYVLiYwCbKubeP+Q46Liok1/3zzX0z
         Q3o/y8p7R3JWigzK/FgjmJ2WrARJb9zq5mxGMD97pr6yenRcUkGdI/wzfP+Agg0DmmAn
         6Wwg==
X-Forwarded-Encrypted: i=1; AFNElJ/Zx4ubr3LPATLFqxVm8okBPjO/5+qu0RHtGYLfJRqZQrFG/ZxxULv6XnuDGqYmsTk7mt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3iReKoglU+9Is2G5nusDp6T7TEU01Xea0u1WEoj7f41UKz2x
	OFzW+SrLhI0YVigRTiofxLI97n9YcnirQI9GhKHQ0YHiAMxRpgF8oStkL7lpbcZsoowTR10761t
	tndMYtz3fGKAOecqw3O8zrekaw33V4MMHQIxiCVWWvEQs3e9Yo6jVxnrGfko5Pg==
X-Gm-Gg: AeBDieup21T73NLchlj5WRrNomjQBZ4zk0EzZgPeOFIN7tr2uLTN1VN8fUrTO3oh5zN
	KBC7PX9SP2zxDasMFMvrgaEZl08I5wZf1XPDFuoz2kObmOsIxQh7f7wJOrtLHjmEZPfprLcwHg1
	9PfA/1C48D9pgFIC+KLCzlNxf6kvBGF2Fa0c8qF8+WmbTKHqNbvEmtnToULvvWJBk2EJRXIzIyJ
	xnEUFf+EScbYyBlTirEWMDcGZk8tXTE8yoUacGf0XMIQwLM1B1kpH9SMUgjc7gbC4ZUProDhz2h
	G8rly7ikDIljQhZWMyICGj2VtLAhE3kqYpEdOFYfIkUDkor5cNKnKQo0jKhdlH7241wU7X2LoH5
	fXHd9wEf0j0sXjcxgm4oLyw7Zqf+vMuFvCL3MsJlm
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48e5dfd6a6amr83500565e9.6.1778220555305;
        Thu, 07 May 2026 23:09:15 -0700 (PDT)
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48e5dfd6a6amr83499615e9.6.1778220554672;
        Thu, 07 May 2026 23:09:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f45d72sm13235625e9.9.2026.05.07.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:09:14 -0700 (PDT)
Date: Fri, 8 May 2026 02:09:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [mst-vhost:balloon 6/30] Warning: mm/mempolicy.c:2444 function
 parameter 'user_addr' not described in '__alloc_pages_mpol'
Message-ID: <20260508020425-mutt-send-email-mst@kernel.org>
References: <202605080515.6jRN5wN7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605080515.6jRN5wN7-lkp@intel.com>

On Fri, May 08, 2026 at 05:26:30AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
> head:   9f56ee36fbf6a6d336dc6a9eaeb4f8a67cb42a31
> commit: c4289f5a4e563611a468b4b5379025a4aa4a7c12 [6/30] mm: thread user_addr through page allocator for cache-friendly zeroing
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260508/202605080515.6jRN5wN7-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605080515.6jRN5wN7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605080515.6jRN5wN7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> Warning: mm/mempolicy.c:2444 function parameter 'user_addr' not described in '__alloc_pages_mpol'
> >> Warning: mm/mempolicy.c:2444 expecting prototype for alloc_pages_mpol(). Prototype was for __alloc_pages_mpol() instead
>    Warning: mm/mempolicy.c:2547 expecting prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages() instead
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


kerneldoc messed up with a rebase. will fix in v6.

