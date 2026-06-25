Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA934889F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782348124; cv=none; b=hR0NCX1HA79xtXf/RmIoZE2FVPMljtUGOK2L8wAUvtA+/v8JwHB8wObF+t5F6qoS2KpvuRkV+9NNAOKfiO/37UB+g6+KPSP5ccA30XCuN1HMJbi6J2Kp6NOO1w3SrWyoyMOUGGvYnLj/sAiCPDqzS6K3e+BugFe/nx1OvhExzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782348124; c=relaxed/simple;
	bh=YB5GE7E3Xs7izwgjr3ob/9chSpyxHi2CWbqKKsIl2LU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DzaTYzTUKsVbOZuVRb3HxCLMJfwyQC4h8edfCgDHSYILsNnBpdlp4I/xqrBGXe7w7k81o2sZRrlog3/91kR3msYu3gmvXhJB5ZDRGKqgLkM0cn8mdHoQQBf5bSYYP7+nas5IwIUXUOybdhrmOSe6L7IoQr29aBRXfNhNmInTrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ld0sQ5pn; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ld0sQ5pn"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c860544c077so2058063a12.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 17:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782348120; x=1782952920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DFjavBCbzblLm5XoFLaw3Sc1sbInL5uPLu8y3/D5AM=;
        b=ld0sQ5pn/27icAX0On2IPZvHVbb1d6nmZGTJ77Xwd3AqbJmmFP1dbrJ1KIK7QVr+Sr
         OOHdZwUb8C6QCd6v+gV4lerzyvAV6L472C86xkkL377yEUo9vI0t6C49OfkXqBTv2SgO
         AgAOwUGiioi3H941wg4zObSQCX8NjKD71d7bU8Yki6O4Mc8y+zbaQUO8q43PjwqXusQo
         pNGjKy+0V13aLP5zAXBSZnCEQhl6JgDvrAF4KuV+V7qqhJrtmPWjWHFaFKfpPrWVDSVQ
         vACTwlCEzHh62qfUm9rDoKAwTB1z+/Ey8VDCdKWDLum/x3s5KhLBtawQNrjtYoX8vkNv
         fjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782348120; x=1782952920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DFjavBCbzblLm5XoFLaw3Sc1sbInL5uPLu8y3/D5AM=;
        b=bzw1Sy4r9+uTGtG8qfL0RdpTdqKS9ZIHjpW02FaZDTP1/fMSFaaRNzI/FQA1y1AJEG
         bq4pORHqSsXcSo5ebt1dFENWeuO5JAfHRHdDVWMuHxlWB55ULzf/XZrEBIjz88JeaZeD
         PkBTPaf8wgynRqRLXvyNcnya09E/iJfJaFkncXl/Xs0cm3/F5RKxftmaWJYPce27anFK
         aS/UA+yPCKmyv8qb2/KCG4wPLlSC20D6rPNzO4yK6baNcy6sd0+Dm+5etMNjppXbnc+z
         OpToRa3JSmtTFW8ZwoLUcwItK7OrdKwR5lSHWtANUBlMkoqtMyAheK4r69MmpLNLvlez
         obiA==
X-Forwarded-Encrypted: i=1; AFNElJ9mzc9z5DEAFRdLQa7UU25l6eF6Qm8wd/qxcOuYTudHnG28efkNoQkPi+oVpwFDyjygIrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53eOvB+YjI+KRYOWlS2EbX7dUSQosk3rpby2ukiQ/PZ9GZavv
	QXelxEc4bP0sOdbASya3fD3ddnxDHaMXU2fiFGW2z3UTiuoUSlILkQ00VANePJ5P8XSt4VG34si
	df1YHVQ==
X-Received: from pgbbo12.prod.google.com ([2002:a05:6a02:38c:b0:c80:296b:72cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa3:b0:3b4:8bc6:138
 with SMTP id adf61e73a8af0-3bd4ae9cd56mr397852637.23.1782348119218; Wed, 24
 Jun 2026 17:41:59 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:41:58 -0700
In-Reply-To: <CAEvNRgHYTFnHbsLLgMTCSitmnp1_j9Pomikm9qmpGTh1w8YE5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
 <aji/2svhcc84rn5w@yzhao56-desk.sh.intel.com> <CAEvNRgHYTFnHbsLLgMTCSitmnp1_j9Pomikm9qmpGTh1w8YE5Q@mail.gmail.com>
Message-ID: <ajx5Vrz9ma--hrGH@google.com>
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the default
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> > With gmem_in_place_conversion=true, userspace can create guest_memfd without the
> > MMAP flag. In such cases, shared memory is allocated from different backends.
> > This means this module parameter only enables per-gmem memory attribute and does
> > not guarantee that gmem in-place conversion will actually occur.

KVM module params are pretty much always about what KVM supports, not what is
guaranteed to happen.

  - enable_mmio_caching doesn't guarantee there will actually be MMIO SPTEs,
    because maybe the guest never accesses emulated MMIO.
  - enable_pmu doesn't guarantee VMs will get a PMU, because userspace may elect
    not to advertise one.
  - and so on and so forth...

Yes, there's a small mental jump to get from "KVM supports in-place conversion"
to "I need to set memory attributes on the guest_memfd instance, not the VM",
but I don't see that as a big hurdle, certainly not in the long term.  And once
the VMM code is written, I really do think most people are going to care about
whether or not KVM supports in-place conversion, not where PRIVATE is tracked.

> > To avoid confusion, could we rename this module parameter to something more
> > accurate, such as gmem_memory_attribute?
> 
> I asked Sean about this after getting some fixes off list. Sean said
> gmem_in_place_conversion is named for a host admin to use, and something
> like gmem_memory_attributes is too much implementation details for the
> admin.
> 
> Sean, would you reconsider since Yan also asked? If the admin compiled
> the kernel knowing what CONFIG_KVM_VM_MEMORY_ATTRIBUTES means, then the
> admin would also be able to use a param like gmem_memory_attributes?

No, because it's not all memory attributes, it's very specifically the PRIVATE
attribute that will get moved to guest_memfd.  I don't want to pick a name that
will become stale and confusing when RWX attributes come along.  The RWX bits
will be per-VM, while PRIVATE will be per-guest_memfd.
