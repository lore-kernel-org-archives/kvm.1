Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E444AA1DC
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469892; cv=none; b=lzu7fPglgaoNVNSyfJJGLujp+lYgd+/K7yWridIB8AE1PUV9z7hQmQmRPZQwD4/as2aBvacdFSW0yWD9yfWwX2JgE2A4FARilGLUhzh3SxAGkGtLBXmf6DOZgrVg04pLO3gjt0kdVHZ2dLK3/S2gArHygAXimftpVLlKNpxsmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469892; c=relaxed/simple;
	bh=y6tsqk6AbIyAr7ZHOZE4yfcg5FKRtSLPGKCc2OxsVK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWNGCl/ch2HIr61X4olV2IuitFSKIyDv6gdRquIlo27zIaprk3LiYiSKce3IMEwFTgHwlP1kysw/NyLB7xv1a6lYW4Fd/BCttx1QYVZAeV9tYi5Lv0rQXgttdQwD7hTkL+fudfqnn+XoiRcMLYsa/Nu6Ay/CYnmcacAtrs6fg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtOYFIUI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbiyB66O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtOYFIUI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbiyB66O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791469889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JF7Ta6gHbbM6OiD0wWKL/0aH7iYTDJLY+u4XjgyDc6k=;
	b=WtOYFIUIzsQ+mtrlRY3CJ4II/0Dq6bfpN0sbwye0/6iVJ9/dTXiL6UayeOxVxaQw0f+GOd
	J5ot2VY2lfIMyLItA3XLeXPqIGTGhHWJ9GuJM8KELJW8d2Ki4I3hALwhMOd60k6TTTjdP6
	DIZVifGpAQ1WtFWNXk+8Rk5HOLFNKOY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-F1B0QcmYOM6Ncgc_NhlnQA-1; Thu, 8 Oct 2026 14:31:27 +0000
X-MC-Unique: F1B0QcmYOM6Ncgc_NhlnQA-1
X-Mimecast-MFC-AGG-ID: F1B0QcmYOM6Ncgc_NhlnQA_1791469887
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-535252004e9so99527091cf.1
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791469887; x=1792074687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JF7Ta6gHbbM6OiD0wWKL/0aH7iYTDJLY+u4XjgyDc6k=;
        b=AbiyB66O5z0rJxcQjSQC/5lzB9sR6qXdbOiHcK5Uw/MsvRX1845FTWfAVnJotYFed7
         OhEPnt03kfCNDW2eG5yMt5USkE4BDYaCMXf9fcmVAZ66YhMy4y8sHjTfjTrwc8D/VqMM
         1R9v5qzh6+pA23z7OgFYikAx8nmIBXbLpz2DH+P5CGFBwJvmTNadi5wbaXakeDgxIS3N
         TM5d5rc+TdkHTtkj2aYWRfAShD3Q3wzJVbz8v/2ipIldMbOiI1ff/EZbP2JaYbokvbfo
         CbVbCq2yKzsD/o2mM0ag7j3DR+cHpDeJI60vUZa6r5erPIcU0HPMfZLAQFxqFQ6oIKgH
         gqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469887; x=1792074687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JF7Ta6gHbbM6OiD0wWKL/0aH7iYTDJLY+u4XjgyDc6k=;
        b=rF6Ua5H06HTgP1gO6wgvZGa4cytGK+qDd49HG/yOwMrdAuGt8QbfY2QoGzPIslaf4K
         teYQ4ZW9FwFj/thS3WYzzG4d5gZ6nHHWGq7q8tJVIb4FZwYD2j59+hglVkCbj2HKB9gw
         N6EHWfmecBvIFL0sYN2r7JW43rCqVJkCEIt2ZiKS/uLK3/YbzA4TTCtbsmKLkefONklG
         IXu5EfFgxUxpE0D+Z1DsTOMO8Ykrt33n7Qh8gyvmPUIJtp8srlDfNGpdGQGHuneipTet
         vATmJA2CnXhwQYfGRf+qWVVCM2TndMCdr95HL2PkuchFWhDhj+R6n0Rdia88Xxo561b9
         VY0A==
X-Forwarded-Encrypted: i=1; AKwUvBz+ORk4VG+zE20eKWDLQfYBcc33GWpFsDFBz9+5mKBYqgsvO7QVKLeoLnFxlXEbEWTq16U=@vger.kernel.org
X-Gm-Message-State: AFuF++kn36YNbXkczNsPbE/PDR5EH9hNzJlsrvNP7tPY0WpTMFKmaGwq
	/jQnL7ioGkZRJGg1AFr0uPMMg+X2AFFe5rQ9T4VBBPVONyLsXxJIE6yAVqpPnox8u0Su5PPtuhr
	gmsg0LV0W3nUjyzpNuOVsyIUu0GtBzAvHn79OkipJTQIXdIZnO/Gi9g==
X-Gm-Gg: AYBFou0mDeltILpNhVzYc0ZFixSShtHR7MGO5cGX8/UHyGmxiJpW1Ctj0EnKt06nWrr
	LdGXcP0QLzPj2kT6Uz8M0+6QovwWmj8J6p+Pw59KwO8N5P4zimAJ+ha41i095Yg+cpJY+v/eAuj
	M/ZKk9MgIoXS/M8oyYoWFM3zE09UcClvS3HgSQ31EwLD8ZE1+3gty5v8H7MKfxU6XRnXfF27WwZ
	ZV1wz+ZKnbOqipCTtdyWql8AwhBK2+Yw73MksgD1SPBPrXcS6WI41NEEYPxoP28rwQupja+qIey
	3eVUaRukVNTUEQ62/gMl0Xnt4KePm0rwYdVBLy1ISON5Ka1aqWxsHcLEAWmyy6h73eiEXC0=
X-Received: by 2002:a05:622a:a94b:b0:535:7692:786 with SMTP id d75a77b69052e-5357692097bmr76092391cf.20.1791469886676;
        Thu, 08 Oct 2026 07:31:26 -0700 (PDT)
X-Received: by 2002:a05:622a:a94b:b0:535:7692:786 with SMTP id d75a77b69052e-5357692097bmr76091641cf.20.1791469885818;
        Thu, 08 Oct 2026 07:31:25 -0700 (PDT)
Received: from localhost ([142.188.212.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53598929ef8sm1154211cf.24.2026.10.08.07.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:31:25 -0700 (PDT)
Date: Thu, 8 Oct 2026 10:31:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <asepPP4Buo9u5p5E@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
 <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>
 <araC0YkwLVPhGfy0@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <784c4ecc-da9d-44b8-9adc-1d1e92d20ae3@intel.com>
 <ar10Ncg2-GhzgBR9@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <30006d88-6679-4274-87fe-f1ce8732577c@intel.com>
 <asan7ETOVEZqRehY@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <asc2_aQ_T91bwMIm@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asc2_aQ_T91bwMIm@tlindgre-MOBL1>

On Thu, Oct 08, 2026 at 09:23:57AM +0300, Tony Lindgren wrote:
> Yes GPAs are part of the MAC generated by tdh_export_mem() so cannot change
> for import. This can be seen at the TDX module source at [0] below.
> 
> What if we add a flag for the memory functions to describe the type of
> addressing used?
> 
> [0] https://github.com/intel/confidential-computing.tdx.tdx-module/blob/tdx_1.5/src/vmm_dispatcher/migration_api_calls/tdh_export_mem.c#L1083

Could you elaborate some more?

IIUC if the stream is encrypted with GPA info, then the gmem offset is a
no-go, because I believe in that case we need the ability to apply a stream
of encrypted data to one guest memfd.  It means even if gmemfd can be
attached to a VM before hand, it doesn't describe GPA address space, so I
don't see how to verify the encrypted GPA.

Thanks,

-- 
Peter Xu

