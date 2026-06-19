Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF53546FD
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857079; cv=pass; b=A+PRYziJwyGb2PPdB5KuHDd02oWbkGzjPq0kPEfAQ3iwYJty9JSGVIkYzqVH+pnEC6aTJqPZOa1x9k5IRNCVdoU5s5F7NVThSHx/Fm2wfhSV7bhYtc7aQfEgiTLr9m0YK8hY1iChyKuCmcp8T2sTvPdymzxDJPIDHG/VPzLRBeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857079; c=relaxed/simple;
	bh=KA6DRUYfMDNKEHfy7weqCq+2Yu35KUFPv1pvOf6mSHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQORUMS5pf21M5Ft3waZ83diDqRp6973TJUJ8oVr4FOIKfJ+nH+qs3LsQjRffYH/wPaQR7RiArWQRapOOSjDqODV/k2xPlKzD0jDXCkfG7o8ss9ii0tsgbqISB+E21ovfN4YfYU7K7vL3g4QnKioZpvVjVzjsD71621iC2lUDcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNCl+yhd; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNCl+yhd"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51765531803so196411cf.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 01:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781857077; cv=none;
        d=google.com; s=arc-20260327;
        b=jwAPnLgcU6lxCEE7JM1wcCtI6JA5Cxrzz7bjhVvl0f3k5ASgncWWaABFbrha1EHtJv
         hCcX0WLPNoEPMJ52WWUF5mjj+9vMFmHN4IqeqY1neUEpf4YfJbnpyEDpY8MVv+pnPpVn
         NJEreHJp1umI0Grhfs7vx1lmB6WaCYZixpCWAlYB1U1WFI1+IrAdvJN+gVLR1xGk5Wen
         WQ8ki1Po6j5E82nS8A5g9RwxkJ5G5iOcM3Axcdd1Mg+FNYNSUfRRXwwdxKsew16WXFeK
         84JBRUJyiTKh7C1wEMJgE3Xg1lugZRsi4VRD3HpcQDZXnxxnDH9rkeVPzNXQ4mOyyNA+
         Bc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KA6DRUYfMDNKEHfy7weqCq+2Yu35KUFPv1pvOf6mSHs=;
        fh=oEwR4x3OGRf33QNjfhY/fbPKfUBzSUHvQyUF2kpHU6Q=;
        b=YuY2W+kTMDu8BnTepTfp0Fhorek1A0WkxHCC+e9XcS8IOL1n6lYHs1QNSUwXjVq6aF
         DJP6zng8YmfdeST6g6iLzJneOAw7z+11vNbW1Cn9bNv/EELBQXlAzfp/0fWICX1IlKpN
         aC6jJpU4PK+gxcaXQYZCLVkNMKtwKbFh1xmvRJQxTkVvgPusllzIbzcpw7Wd1G2mKq2A
         0KHaviIRwqP/lrQFuatCUePOZqZmNza9e4qYnMVa02+hN050M3xW4HrS1/iwzhXz5uuG
         1Wn7AvoB0Gx/2mKxRReqNo8GOg1AyKzzguyrS6oOkOZJDxxDST3LwBX9hLsyrcciMNmo
         O//Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781857077; x=1782461877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KA6DRUYfMDNKEHfy7weqCq+2Yu35KUFPv1pvOf6mSHs=;
        b=YNCl+yhdJjliRDrf/MwCHc4ilL9Mus8tqQTzFZTDjIdghYuwyZj8708eUqu4ncBWf9
         +7TZT4MZHIHuomEjMIqY4nS01n6OJ18wu+HTJMEeBmquy7Bx1Iq2fL3OBYyBNVW8111S
         FjqkJ6dbU3x5Zw/8SS2dzKkszzvzsvkOAfuae5sN73geioR2y3NGCZuTapT1HOXIemtU
         LQBBK/zw8rhD1PQn99CmMz1LCjFH7l+va9kaiVYSWrQa+FnAIvriVoplW58lhuPOvC9C
         KGXHXSCCmDIEQyDSNRl4XPbFewKySoITPQn/UFd1LmDeRpTntOYzAxstzpUpE8x+IoGV
         OPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781857077; x=1782461877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KA6DRUYfMDNKEHfy7weqCq+2Yu35KUFPv1pvOf6mSHs=;
        b=dR3N8v4shYnynLgmQ1vpu0WCTfFzcoFl8ifzI1QwqCZisZtS1Zk9ZOWp8WZ3XTmWOO
         dzEbYDhn1mdFpbuzblCObQ8hJ7/u+JqemLWf99mySr0K2JZXQg7a9Jx5nubVdDOauODn
         cr90RDG2xW8XCgO7FlsuEut1F7Cr+sN2fGQIFDbALVoFJgktQdMEWK1gRpj5XwKcxGBC
         dEYu0YsvUdGk/qSjMVxPXGyfTphRYrJLEsTUG9cVp8QD6/76l5RLXQfqTtV9byFFxyuH
         oMb5JTZX3837zAeI8Vqq12687dLtlfSR+SZ0vn8kFxwKQ0i0CBIIiGWNVFCDyrR+g/V5
         hkQA==
X-Forwarded-Encrypted: i=1; AFNElJ/l4ckkeufSQClqoFvHovyaJ6D5kGhsrLxgrI3sf64djbyWF4tIr4niaAc0LlmBVbpeaok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wU0SmCRpCrOBCseeLVV7DHu/1Mlzf8SOdZGYlsaLSqjgrqgq
	t//iMsoEKmc0omHfFA0sUJjtJXy5/7a9UICkXnbusI8BwfjFHK9BRagks71xrhstY6XxgfJ7ui3
	5dRD4PCTFRnnBqkZMSciH6zTINY2fp3xyNW20Evf3
X-Gm-Gg: AfdE7ckGDy2cwYWPeAo/nB4bBwa1x/nM4nQduv75GYiMFQjNEzup27NUlWtRmxwopYS
	WqvZInDRlY3WH4xmfinfgIHeQijtjTIIYEshlUdjLrrx1iqWd3Z6xlaBkWim8gBnP+3d8T2W/OZ
	llrw5sZYl/Ph5Q5RRW+eRZxKxTDPSo+YEg8U7taefKB4e9hsEEQhBrVbENvN18zZ+myy4+ta4qv
	VNLmT+ZieWXHbS12FNqPQODzPwB67KOpdRJ1UvjzITiR1CnFZa1M/KDftMcmn+yqS37O2zjWg==
X-Received: by 2002:a05:622a:4183:b0:517:5ec3:b59c with SMTP id
 d75a77b69052e-519e489116cmr7174671cf.2.1781857076604; Fri, 19 Jun 2026
 01:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com> <20260619005533.984EC1F000E9@smtp.kernel.org>
In-Reply-To: <20260619005533.984EC1F000E9@smtp.kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 09:17:19 +0100
X-Gm-Features: AVVi8CdmXQJb7WzuENzIP0MXl8aUdhwXeoyf7m3f_2laETL1i2q75b6p8_BKkxA
Message-ID: <CA+EHjTxdN+TsqSyp+f+8QO-BbOgHEebmpMhJbmD0D8quWg3s8A@mail.gmail.com>
Subject: Re: [PATCH v8 07/46] KVM: Rename memory attribute APIs to prepare for
 in-place gmem conversion
To: sashiko-reviews@lists.linux.dev
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 at 01:55, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] `kvm_range_has_vm_memory_attributes` iterates over potentially m=
assive ranges under `rcu_read_lock()` without yielding, leading to RCU stal=
ls.

Not a concern. The xarray walk is pointer comparisons with no I/O or
allocation per iteration. Realistic ranges (memslot-sized, low
millions of GFNs) complete in microseconds. The "billions of elements"
scenario mentioned below requires ~8 GB of xarray metadata to even set
up and doesn't happen in practice. The `!attrs` fast path
short-circuits via `xas_find` when no entries exist. This is the
standard xarray-under-RCU pattern used throughout KVM and mm/. Pre-
existing and unchanged by this rename patch.

/fuad


> --
>
> Note: The format of this report is altered to provide a free-form summary
> without quoting the original patch code directly due to recitation restri=
ctions.
>
> commit 05536cc2fad8dac656829127ace4d82d1b522580
> Author: Sean Christopherson <seanjc@google.com>
> Subject: KVM: Rename memory attribute APIs to prepare for in-place gmem c=
onversion
>
> This patch renames the memory attribute APIs to include "vm_" in anticipa=
tion
> of moving PRIVATE tracking into guest_memfd. It introduces no functional
> changes.
>
> [Severity: High]
> This is a pre-existing issue, but the kvm_range_has_vm_memory_attributes(=
)
> function in virt/kvm/kvm_main.c appears to iterate over a potentially mas=
sive
> range under an RCU read lock without yielding.
>
> The bounds for the loop come from the KVM_SET_MEMORY_ATTRIBUTES ioctl
> handler (kvm_vm_ioctl_set_mem_attributes()), which does not place an uppe=
r
> limit on the size other than preventing arithmetic overflow. If a user wi=
th a
> large memcg limit pre-populates a massive range, and then calls the ioctl
> again on the same range, the loop using xas_next() inside the guard(rcu)(=
)
> block will iterate over the entire range.
>
> Since it does not yield, a sufficiently large range (e.g., billions of
> elements) could run for tens of seconds, causing an RCU stall or soft loc=
kup.
>
> Could this code drop the RCU lock and yield periodically, or process in
> batches, to prevent unprivileged userspace from causing lockups here?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inp=
lace-conversion-v8-0-9d2959357853@google.com?part=3D7
>
