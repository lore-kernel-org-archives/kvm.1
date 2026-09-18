Received: from mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAB3B2FFD
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722906; cv=none; b=kz9C8ZMVEuKO6NX82xIrq8SlzDcrECZtJrvUBalDEVSwWSEwvglSBjvC7zjqoeSlV+bZcV9fdt5nZiK7LXFtqtOS8bFvVgbFJk38ZXA8YGLkFmlCkJ0NyjQKVQF5fOPtKJDYpyhVPWT+AZuScXxTIebA/jOWG68O5Jo64HxaUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722906; c=relaxed/simple;
	bh=D0PKzZhQRsxn3gOcYMwqRGpkhs/bU2h6lOLFmUyfZXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZ0gO7P0ITEceThKqC5oMmTME3eyuA9gOoV7uGb9orBf4CGt20AB4KYPb6DX0BkGOtP/8d0HClQdsNVBU809mOUpx2dMiEBVjoa1cTwptJr/xhvA/7yNjqVxh15CPCLe0fn3R4ROGALY+8cqarT+9jLjkoQf0VfXgxIDZ+pbOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xilwTkY5; arc=none smtp.client-ip=91.218.175.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xilwTkY5"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=D0PKzZhQRsxn3gOcYMwqRGpkhs/bU2h6lOLFmUyfZXg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789722902; v=1; x=1790327702;
 b=xilwTkY5bXLeU8YhzASbJG+fqWWzK4CgvrNY/2BPbSuJuQt+Khw/pDXC4j09hfwjrMqzsBsj
 UA2RfVpm43+DxSr3uL6nIm+CdbizkeQT1KhUYgHd3ucF5DPnkv3+aMp2ivpMH11/+VIDrQYtCsz
 UvnrcaCrsLeztohRfRg3J8SM=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ffec458f40ca2faa;
	Fri, 18 Sep 2026 09:15:02 +0000
X-Mizu-Trace-ID: ffec458f40ca2faa
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso5319e87.1
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 02:15:01 -0700 (PDT)
X-Gm-Message-State: AFuF++lHCdbHxDfLxB7/xt/moCjrX2oC1NsYp6tRfOedw3o2u2+W32hB
	cbPnLSyRHM5lbqzOCi13yHG8N6XBewachp9XXbcoyV0iVUSusa0p0P+3/Aw6BvD0fFOCPO23GVe
	PSnh3tW5rTgZTWtI9UeJAVzTTZkPUG7Y4QTSAXeqv
X-Received: by 2002:a05:6512:a96:b0:5b4:9dba:7401 with SMTP id
 2adb3069b0e04-5b8c17f53eemr77720e87.11.1789722900983; Fri, 18 Sep 2026
 02:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915160141.3543048-1-suzuki.poulose@arm.com>
 <20260915160141.3543048-6-suzuki.poulose@arm.com> <CA+EHjTz65G0MM=tOrzmk=jMweBX1us6FqfrmSkQs4KSyAEoxhg@mail.gmail.com>
 <e26cbb4e-84e2-4fcc-9eb0-93bfd4aff4a7@arm.com>
In-Reply-To: <e26cbb4e-84e2-4fcc-9eb0-93bfd4aff4a7@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 18 Sep 2026 10:14:24 +0100
X-Gmail-Original-Message-ID: <CA+EHjTw6TOSEs1GtUcUy9WACpGRJBA9yTn9Ro_+tiD=XkeHr4g@mail.gmail.com>
X-Gm-Features: AcwNN1WAyYZFMS1tYTqzPWruuztc5hWFyoH3hZA9fEYOfU0jxVOmsQMTpwP1D70
Message-ID: <CA+EHjTw6TOSEs1GtUcUy9WACpGRJBA9yTn9Ro_+tiD=XkeHr4g@mail.gmail.com>
Subject: Re: [PATCH v18 05/23] KVM: arm64: Track the type of VM in kvm_arch
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On <date>, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
[...]
> +       if (WARN_ON_ONCE(!kvm))
> +               return false;
> +
> +       /* Cover both pKVM host and Realm VMs */
> +       if (!kvm_vm_hyp_is_distrusting(kvm))
> +               return true;

I'd drop the WARN_ON_ONCE. And this early return needs the `>=` from
patch 13, or non-protected pKVM VMs skip the filter.

> I resorted to is_protected_kvm_enabled() to make it faster than using
> the vm_flavor checks. I could rever those anyways.

Agreed it's the faster test. I'd just call it by name at the three
sites rather than through a macro.

> Do you mean something like :
>
>         if (kvm_vm_is_protected_pkvm(host_kvm))
>                 hyp_vm->kvm.arch.vm_flavor = VM_PROTECTED_PKVM;
>         else
>                 hyp_vm->kvm.arch.vm_flavor = VM_PKVM;

Yes, exactly that.

> Do we additionally need to WARN_ON() if we encounter a VM_REALM ?

No, the host shouldn't be able to trigger a WARN at EL2.

> Apologies, I thought this one didn't change, but later patches changes
> them, which is why I kept this.

No worries. With those two in, please keep the tag.

Cheers,
/fuad
