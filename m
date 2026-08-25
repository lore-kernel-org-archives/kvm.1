Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF73CF02D
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692160; cv=none; b=D/CyrI/JWw+6XyikaCUfyGJnzh7w3DwomIxPqrP2eKDFQPBkchpRPAMldvHiA4hD3gyBc+FPlgCVRebdG8JVBtGX7/6Esu2AX1ZKjzwTL5ZGWwkn6dFZdsdycQBScRKmRvQ3Jt73vQcJg/+VrD6JVWIyqLtDV8S59EoQxLZrs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692160; c=relaxed/simple;
	bh=sZh7+Yg1RuvZGwbDoj2Th+jix+X+LlL6xZRNY/QZh9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMh/aVjXYnyAkaTvQqU4//Y8f5pd6Sgv/XQoCMiLZRcyGhX/E+GWHs//hwfYfqQm5MN0BGaHkgouW81dtXChyOKSpemUlxrNecEM2Hz6SkLZ6O9gKN9wKJdJDYht6Iw+b6c+S3vU+6cf7Rfz9segByc0T6eRfI6CO6lIIMV0Rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dZMVzusH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZMVzusH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso492384a91.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787692158; x=1788296958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XEWwzwm0+KgrrqKho7ClIK9G3IzWKnm2/x3cuuIS4Ro=;
        b=dZMVzusH/NqzvXczfq5BdSeTv4B67gXLQoTfnCDcXZ2BO2Y46bNT8vciuOORUiv/sh
         Swo46lyxPnp615IXxdyIvfAR5tGmql4AvvY2yWxDzHRJFgpyny7GZPIy41N5BQa05oT1
         3RZRm6ej9tamXWl6y7anP/ptZBNOHFknJduG4Tn8jCSYxKpBXQXpiB0Lmqi+fL+qG/n1
         q0rjUsTxFCuF3tbZ07DbnEyoSwS86C4IBe4dgvdLqDhBm87U96eXWzBC06XDVk4IiiL5
         ZMCHjr7ao9uTwn+mOUre//rd5R5ElEUSt2Qxf9FW4jMqN9XAy/k57tMtuEnhBijGLaby
         0MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787692158; x=1788296958;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XEWwzwm0+KgrrqKho7ClIK9G3IzWKnm2/x3cuuIS4Ro=;
        b=D18upMcbJxisilZQ0Q8wIkqdjqth3yKm3TzVmoBNd1GpCoUlXh6ER02TmyOGMqO2yj
         CAszVdlkU0CWyLoSHWYaQLQujIfJgbQ3fDAptFsuvTrXI630voQ91krisO7vlXNcO6b7
         9xlFf1QxN12XLTkmJ8kef2Rlg0FGGE8+qU50o2xakhUfmQN1zQE76omA5XBVkwKY36OD
         rImDGihNeKSskOAKIew51vmVHOqSgjy6uOWxDUERcNFJLeaKXW1FugpK5p6A8LNY3DQB
         Sal7FtzFE2xLkxArjlGGqjYMCDtIdd77DDSP8iX7WkuDFjz8nRkR+Us8xOKsCA5wkuXw
         3FJw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3ZAyoYmIjpTv9Mr2jYcRiNFq2hdibwfW+rmivyOTn0P1bw/EtrTru18bxWJlDvDvB8Y4=@vger.kernel.org
X-Gm-Message-State: AFuF++k6sKz0yVPpv89lk2haBXYgft3uyJREdlfZgGfThfGjg+69+S0j
	xbWBY6LQb78eiLR0BoIswm60/avUHcuOl7OPLDLhN9ksyjMaXwCWT8DkKgMqf/bBMsM=
X-Gm-Gg: AR+sD13QD8D7FldEH4gupK3zm/ZqzTUjpjn0qhh8FSBcIVGxuKcFe/ilkfK/1exEy2Y
	yIO7E1ekXMLPuf9fMZSsWNgB7YTnn/p5+McEE6R61s7WUaDL3pPjvDG0Gpk3dU7azI73R3F7VOj
	aB+sazst9orm7PyUB7z3YhCW4A3RNmTNPpRl4JTXbIGcwZEbOdzmX8wyCXYMO3NWPmFtqyjIaEF
	PJspO64Y7yudcqIIfWRd9TCSqLqmGO9RSWdDhkoRGDvmqw+OdA6KLaMGvHUB0S8rrfgxNF0NDzI
	WZjeG41Fe4i+t2yogauuWzmYlzGWuXqbKxQaeA1iOcYaXH8/3ftf5HCS6AK+u/X4zkL891xNdHi
	kjmCGZYcs4T/MpiyIVD/uoYSqYZETrrSjQEJKHXwrxAHmycphIqTgzipL3UT60B6r6p/rD4B1qV
	bIY2y0pnw3LydZhAtao8RYE2vOeoO210FCbYp9Q9AcGMHF8ppUz3BQvRB9p54Z1vFK
X-Received: by 2002:a17:90b:2791:b0:395:7fff:a08f with SMTP id 98e67ed59e1d1-3966cffb1c7mr4401126a91.0.1787692158304;
        Tue, 25 Aug 2026 14:09:18 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a5a55esm1158770a91.16.2026.08.25.14.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:09:17 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:09:14 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v2 00/24] Add Realm support to QEMU-VMM
Message-ID: <ao4Eetq7oAAsipo4@p14s>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
 <amrYWWyWlhnN2Fll@FCCLS0092175.localdomain>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amrYWWyWlhnN2Fll@FCCLS0092175.localdomain>

Hi Kohei - apologies for the delayed reply.

On Thu, Jul 30, 2026 at 02:11:57PM +0900, Kohei Enju wrote:
> On 07/28 13:26, Mathieu Poirier wrote:
> > This patchset provides minimal functionality to start a Realm VM
> > from an Arm RME capable host using the following command line:
> > 
> > qemu-system-aarch64 \
> >  -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
> >  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> > 
> > It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> > back.  It is compatible with Steven Price's v14 revision [1] of his work adding
> > CCA support to KVM.
> > 
> > * We are currently working on rebasing the work to v15.
> > 
> > It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> > here [2], along with the TF-A [3], RMM [4] and Linux kernel [5] for the SBSA
> > machine (compatible with Steven's v14 patchset).
> > 
> > Instructions to compile and run the entire stack can be found here [6].
> > 
> > Device Assignment is not included.
> > 
> > Thanks,
> > Mathieu
> 
> Hi Mathieu, thank you for your work on upstreaming CCA support. I've
> tested this series in QEMU-TCG(x-rme=on) environments and confirmed
> that the basic functionality works well.
> 
> I have a question about a QMP command for querying CCA capabilities.
> 
> Jean's tree contains the following commit adding such a QMP command. Was
> this functionality intentionally omitted from this series?
> https://git.codelinaro.org/linaro/dcap/qemu/-/commit/41f7852cc8590a38c47299a35a7238da09ff9a12
>

git.codelinaro.org is no longer accessible to me.  Please see if you can point
me to the same patch in this repository:

https://gitlab.com/Linaro/cca-public/qemu/-/commits/cca/2025-09-12?ref_type=heads

 
> We are interested in adding this functionality because we are also
> planning to upstream CCA support for libvirt, which will need a QMP
> interface to query the CCA capabilities exposed by QEMU.
> 
> Since the Linux kernel dropped some configuration parameters such as the
> hash algorithm, I need to rework the implementation of that QMP command
> a bit. If it's okay with you, I'd be happy to send out the reworked
> patch based on this series.
> 
> Thanks,
> Kohei
> 
> > 
> > [1]. https://lore.kernel.org/kvm/20260513131757.116630-1-steven.price@arm.com/T/#m06dd14216aaf76acab65b0a76fb84653141ea64f
> > [2]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v2?ref_type=heads
> > [3]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> > [4]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v14?ref_type=heads
> > [5]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v2?ref_type=heads 
> > [6]. https://gitlab.com/Linaro/cca-public/build-instructions
> > 
> > RFC v1:
> > https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html
> > 
> > Changes for V2:
> > - Fixed linux headers to include correct bit shift for Realm VM (Gavin).
> > - Removed obsolete rme-guest options (Markus).
> > - Set ConfidentialGuestSupportClass::kvm_init() to kvm_arm_rme_init() (Gavin).
> > - Got rid of kvm_arm_rme_vm_type() (Gavin).
> > - Used kvm_vm_check_extension() instead of kvm_check_extension() to avoid
> >   error message when starting a Realm (Gavin).
> > - Removed obsolete kvm_arm_rme_init_guest_ram() (Gavin).
> > - Collected A-B and R-B.
