Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F139B4B9
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024144; cv=none; b=iHfQv07z0D5UqLCmLK111+LXOJkHhTjorLLfj2Ky3geLO4tBeKcZgzGp7v+/ep3Jya4fnlIJKJkk1va2YUirq7AVQVhBMJlbNkIOX51TH9XUvuSkUSPwa41YmUJBCmbi6Ffj/qwG8yMwe6rsctKL6UCnml8I3BUmJ12MRa4OYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024144; c=relaxed/simple;
	bh=zR4Buq8Cqbhx+BoaM3N9Hxez+9qWEGN61TfM+T+/GOE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=dGdzwcBEj4m5hywyU+kDbEq06FYDu+qailhnK2Zk7lhvKqpTJzJF7xtfD2nF3hXYTd8MN6KaRDFeXiwlc5kthISCbzmVQ1Z7KSZc3yyUfBdrWOLacKLkXdNL8jLK6ud/NEZIHI5ra2K8jncp7ZN54vJoPIFnCdnVEqLKSQxb86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ+xoyFP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ+xoyFP"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceaf8a1265so33180165ad.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786024135; x=1786628935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QjVIN0UdWGoOCTancp6az5kLjHEYcF1w7gKX5HKdYSA=;
        b=KZ+xoyFPZc8FZIdY6ETtPzI8oTwr5YDZG/dGkp3gmH2IpSPWxmHiJ5t+jt/x2GElp2
         myWLTYENr5Iw5E6/KMmDDjO0q+s7n3z419sQ4e1tE01MO2fUNjSSscqAhT9krsMxdaOm
         wuNM37tJ6EyIEZF0yYzPj/OqNPAWmBOUQsCm/RwFDyUiuhTOarA/YM7tDmO00vIKuZy0
         1BaG86uIsMSUt4dhO+uoHIgXCNJIc9vmH6P3enEQIiWsXUl9UPV21+rsguEW0hB/J/VA
         4tg/S6WytwXdaF216xNI6xX/pbp92Rql88fvNla7DFtKXVqhX+a6ir7TagxfLzCJQNN2
         Rhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024135; x=1786628935;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QjVIN0UdWGoOCTancp6az5kLjHEYcF1w7gKX5HKdYSA=;
        b=hgmLxI1CUEajEBQ2yroU9mceZ6r/vaYtHDWJPFY1iZwmJBJwNM0MENEe4JP1BFXS+G
         y4v9oZafXrzNAgIAeNCUzBZpSbk7K2EDWYujrR+Flr0ck95HUVpbesd3iIz6laU956lQ
         7vEFKv1dsS3DQRWK5c79q2UPIN/QuWzYuGE8oeIQd1LZHR3IcS7fqbGBgqdvqXr4Tw5d
         Zy2W/0k78CZDaRlB4IreGn3+mLGl936Ta6mAPMTLADPuNRIheDnXBxJM2+rqwY+ec2/n
         ffay4M/GqjlG0Re4p0A5C6f4DtPUe1u+J54M5MBeT4BmOynBegDHR2/X41BkdPCxqjSF
         BDgg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4N88/NW+Hpraeda7T25JZocFXh7LtMdZC8PbsyqK8ub07y9Bnk3USAy+4U3fR2L1FVfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRFxjiJ6lALqoPMDpanrN/NMFp3ErUvQmdwb8JKlyKU2iZEDB2
	rq4CyvzWpHZoS87KBSoTDTb4/YoL2eVNTlK8Qm0zq0eKKtiLh5ACAzz6
X-Gm-Gg: AR+sD10jX41i0EWUgbx6UWpzycgFr6FYiCw/s5BcGR3KRSp5qgEqQKunr1h94RB7JsF
	J7TZ7cXvIge8ofnPTwyo2JcGeJiE+0laP0rZcphzK7MjiFlmYZegbtT8zryssx8ns2m7dENL1Ek
	+TXTXOnr/EocAYbc7tUJvxtiP/ZuFea4Ea4JiSR85qx+ggFdl5YcpL6JS0rNAjDV/d4rplKhLsK
	3pF9H2lk7XXSK9EV/fAqScdCnWTL9ErQNCzHAqaHr1/+WP8Hmx1Z2HXe7e5KM9sk+ep+GumaEMc
	yNqkkktTttvQ1rb01Wfvmg+Lm3Y3y7ZBsSoJekBuZEf/fmlyjz6H1cRppY+UjnEc54IGgNxDrkt
	dl+q0WPB8n57WmTosH2FkJgcZGWCLT5MOG6QMjIC51mdbMCKJZIEck8ywhE88yhCY4zq+9+W10f
	H8RLyzJHBgWPCQQHkm7n6bZhm1z9m5M/KWFA0OgWEp2/TGyeUa9CA4nzX4IVc=
X-Received: by 2002:a05:6a21:6013:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3cb85df2790mr19356193637.13.1786024134598;
        Thu, 06 Aug 2026 06:48:54 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315ae6c1fd4sm6563410eec.14.2026.08.06.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:48:53 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
In-Reply-To: <20260806104222.7e435b28-8d-amachhiw@linux.ibm.com>
Date: Thu, 06 Aug 2026 18:35:31 +0530
Message-ID: <mruzl7qc.ritesh.list@gmail.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com> <tsp8l8cw.ritesh.list@gmail.com> <20260806104222.7e435b28-8d-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Hi Ritesh,
>
> Thanks for taking a look. Please find my response inline.
>
> On 2026/08/06 12:09 AM, Ritesh Harjani wrote:
>> 
>> Hi Amit,
>> 
>> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
>> 
>> > On POWER systems, newer processor generations can operate in compatibility
>> > modes corresponding to earlier generations (e.g., a Power11 system running
>> > in Power10 compatibility mode). In such cases, the effective CPU level
>> > exposed to guests differs from the physical processor generation.
>> >
>> > This creates a problem for nested virtualization. When booting a nested KVM
>> > guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
>> > userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
>> > and attempt to configure the nested guest accordingly. However, the L1
>> > partition is constrained by the compatibility level negotiated with the
>> > hypervisor (L0), and requests exceeding that level are rejected, leading to
>> > guest boot failures such as:
>> >
>> >   KVM-NESTEDv2: couldn't set guest wide elements
>> >
>> > This series provides a mechanism for userspace to query the effective CPU
>> > compatibility modes supported by the host, so it can select an appropriate
>> > CPU model for nested guests.
>> >
>> > To achieve this, the series introduces a new KVM capability and ioctl
>> > (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
>> > compatibility modes supported by the host.
>> >
>> 
>> Sorry, but I am somehow not convinced on whether we need all of this
>> machinary just to get these 3 bits of information, which we are
>> returning today.
>> 
>> Since KVM_CHECK_EXTENSION can already return an int, so why can't we use
>> KVM_CAP_PPC_COMPAT_CAPS itself and return the bitmap of supported compat
>> modes to the user?
>> Say if the cap is not supported, we can return 0, otherwise we can
>> return the bitmap of supported compat modes. This will easily allow us
>> to use 31-bits which as I see would be hardly a problem in the near
>> future. In the future if it grows - we can always use KVM_CAP_PPC_COMPAT_CAPS2.
>> 
>> This should reduce the code complexity both in the kernel and
>> userspace and we don't even need a new ioctl then.
>
> Thanks for the suggestion. I considered this approach

Then we should have brought that up early on during the design
discussion. But for the sake of discussion let's call this as
approach-2.

> but would like to
> go with a dedicated ioctl for the following reasons:
>

> 1. Intended semantics: The KVM API documentation states:
>
>    ..kvm defines extension identifiers and a facility to query
>    whether a particular extension identifier is available.  If it is, a
>    set of ioctls is available for application use.
>
>    [...]
>
>    KVM defines many constants of the form KVM_CAP_*, each corresponding
>    to a set of functionality provided by one or more ioctls. Availability
>    of these capabilities can be checked with KVM_CHECK_EXTENSION.
>
>    The intended role of KVM_CAP_* is to signal ioctl availability, not
>    to serve as a data retrieval mechanism itself.

That's not entirely true. We do return data as part of check extension
for e.g. for getting the SMT modes check KVM_CAP_PPC_SMT_POSSIBLE.

>
>    You may take a look at KVM_CAP_PPC_GET_CPU_CHAR for instance.
>
> 2. Return type constraint: KVM_CHECK_EXTENSION returns a signed 32-bit int. The
>    capability bits are defined as (1ULL << 62), (1ULL << 61), and (1ULL << 60) —
>    64-bit values that cannot fit in a 32-bit return. Renumbering them to small
>    integers would be a UAPI change and would lose alignment with the

There is no _change_ in the UAPI so far. This is the patch which is
defining that in the first place.

>    H_GUEST_CAP_* values from the hypervisor ABI.

No please. Those are 2 different ABIs and there is no need to set a hard
dependency among the two.

>
> 3. Extensibility: The struct-based approach with the size field provides clean
>    forward and backward ABI versioning via copy_struct_from/to_user(), without
>    needing a KVM_CAP_PPC_COMPAT_CAPS2 in the future.
>

This only make sense if we really have a usecase already in mind which
you are planning to extend it for. Otherwise, IMO, this is a lot of
machinary and I think we should consider the simpler approach.

IMO - I think approach-2 is a much simpler for this usecase. I don't see
any valid reason on why we should not do that instead. We don't need an
extra ioctl and all the struct machinary along with that just for
returning a bitmask. The existing check extension ioctl can be
easily used for this purpose.

Would it be possible for you to give, approach-2 a try? Do you see any
geniunine roadblock or limitation with that?

-ritesh

