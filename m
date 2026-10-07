Received: from mta0.migadu.com (out-158.mta0.migadu.com [91.218.175.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6549250C
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369903; cv=none; b=HCUguWledPOYdNV1g1h+ae0DgjtSpusLKtbDpwaGryWZUPh33huSxcrMHYUa6PjQjJ7icg3AVe9/Q7J0byh0ZG8DnVavDiwyxN/YMBeuquN/Juv2uHyhWxZ2hHzmBjeL9BIkuMsWWCQK/2eaRxOXYXcPa22aTwq/T4TIkhsbA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369903; c=relaxed/simple;
	bh=/01lQesds7Qu15IlWJStcj8pAkrlNp3+XW9pTMK80Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQoEfoh64Hk4/iAl2FpaVyQ41m75BQCFiw4ccLxV4QBTCPLcdJbtDu0Ua5rPLhdDTmHA7e8UTJId0Sg1X5ULR9tbUJeb2fRS20zEsLugFQUmkuRRXIstRFXdhTRKOQdgzyFB0dvs5b1m6bZATbwUid52benh+w4UySD8uAx4VTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K6gt6FpA; arc=none smtp.client-ip=91.218.175.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K6gt6FpA"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/01lQesds7Qu15IlWJStcj8pAkrlNp3+XW9pTMK80Mw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791369862; v=1; x=1791974662;
 b=K6gt6FpAZsOqYUyXKxhBmTZ/mSVLNBL0zyN9buD14KvxO8nwdz+X+aeaRu4ctnxxArLSrVw+
 YB4QiuS0cSJM5wn5MDc1W7W30FOQs1DLze3v1swP4rMgDMDgdUlyxXnBIfAevzM59xlltbdDpOX
 3MIsgHwYMDr+0jpPOi2v0ufA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6e4f2a6b8692fe21;
	Wed, 07 Oct 2026 10:44:22 +0000
X-Mizu-Trace-ID: 6e4f2a6b8692fe21
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so7737e87.0
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 03:44:21 -0700 (PDT)
X-Gm-Message-State: AFq9FYJ8hp867eupeI+e+Umc3Q3bmmzY/pzbXCxseFmdzwOvsQg6WbLR
	UeRzz9xdwnS3re+Bt7LueaIdLUa/VqDht2TVSbxf31JfUYL8HADXZlYASOYq+bkQK64l2LubvMs
	7owgocHQVm+rkHAJ1pQZmoPl+ASf89lUPZmHRY4aq
X-Received: by 2002:a05:6512:2c9b:b0:5bb:27df:415f with SMTP id
 2adb3069b0e04-5bcca969b08mr280500e87.15.1791369860573; Wed, 07 Oct 2026
 03:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-2-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-2-suzuki.poulose@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 7 Oct 2026 12:43:44 +0200
X-Gmail-Original-Message-ID: <CA+EHjTy44W8srPO2y2MJT7nijeWcek-BLsiwYfSPXVOA8DpRCQ@mail.gmail.com>
X-Gm-Features: AclHuK9bYO3-lIjbLvu1WEmia2gdqzHBdvJpWxSZu00WMWjDLerDBVC4C9fwiYI
Message-ID: <CA+EHjTy44W8srPO2y2MJT7nijeWcek-BLsiwYfSPXVOA8DpRCQ@mail.gmail.com>
Subject: Re: [PATCH v23 01/14] KVM: arm64: protected VM: Handle user writes to CNTVCT_EL0/CNTPCT_EL0
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 09:35, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Protected VMs doesn't allow setting offsets for virtual and physical
> counters, as the offset is always fixed to 0. The VM ioctl is filtered
> out based on the cap. However we don't prevent the userspace from trying
> to write to the CNTVCT/CNTPCT registers. This would lead to KVM triggering
> a WARN() in timer_set_offset() as the vm_offset pointer is set to NULL.
>
> Fix this by always "fixing" the timer offsets to 0 and marking that the
> timer offset is set in the kvm->arch.flags at KVM init time for protected
> VMs. This prevents the access to the VM specific vm_offset at low cost.
> A userspace writing to the CNT*CT_EL0 would observe success, without
> any real effect. This is cleaner over spilling "*_is_protected()"
> checks and "matches" what we really do in practise. i.e., always run
> with "fixed counter offset of 0".
>
> Reported by Sashiko
>
> Link: https://lore.kernel.org/all/20260908164641.416911F00A3A@smtp.kernel.org
> Fixes: f7d05ee84a6a ("KVM: arm64: Prevent host from managing timer offsets for protected VMs")
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
