Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793281789;
	b=xKTMDHj9FcM2xVuhO2XjH6mflINfRNoybljFHp1dsPxIJDS8DLRBa1uJbVeDh7Gm2so/
	 Znjkdjfa6vnLmRBUjgL4ZcGUFeHh42zNYItfszesq3Jsv+qQYiO6DVb/f9PQsnfj3/Dih
	 b1tGofX4GrREk/uVQ7XdmhR8txwVE1104O3Gi5WTVwNjYwr9bT4B6BDJzQ+S2KOjrlsOC
	 fxbX9P1J9cAj2HcNtpcSAE8YyYEGQtAV/GDfpgQ8iAnDDJi+FAFrc2kj9hRAEj5JOaZ7A
	 hLpZ0JCW9KYDPoxY6bCeNdEcHEQaj6Uf1bB33y3k6mOykMAZAwDpe4C8plcabmgTvtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jdEzrVvS7er6a3IlsJnCTgJPsgC3VSLy9Xk054XJvXM=;
	b=r9503D4JODo51i6njBmmYmlq9l4jKuu2++kH+yNpHXn0ksFKbh3Vu8aHd4xlJrlPx82x
	 7jwN2lK7K+XM4Mf43+kHCn1x7EzW6KaPu6MiqLFJuVDhmSnYmjsEiF3LcN84fal5cF1z8
	 +Sy7AXHmN9kSkdy/xIK8duNnUEd2y6TcbqAnmBZoQ2djiX3Wi69MVUfUaMYXnYaI+gGSn
	 5mVlK4YMUg8SjAEMlFvkakfZTi0Z6oeAq7AkRlyXPL5BgA5gJ7jEcCoLAmFyEUgzPBLSc
	 uURGEDVL9bHcruhYtz43T5sAJMYC5Hfz1SzHSm57k3jaeIQlHVB4OjbXISU8+zyFH4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWV5z5FO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A79606A321
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A79606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CWV5z5FO
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5363c8de563so25400681cf.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 06:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793281788; cv=none;
        d=google.com; s=arc-20260327;
        b=shwt92DSgpwACBWW6BlvTvch0bg7gtJyq01vPLtkR1ZtiTEbvARo5ElCJ3nahw+RjC
         2phaYZ64VJmfyn0hpC+7tLTLYXGxZrQXUdf94bGAFoxltl7wveNjZTMkpAQt3Aqaa2+8
         r02G/LR5QAaZ2or9AlPBas0y6ZXa5LiaoPvEPNw6HGKp1R9SA3yOY/6PLP83o7kQ+rQA
         P3rZWHudiaSCbUFQP1EZ3BDLgZLQZiCLLxCvDZFg52v+a7Kf20splJF0ERHtz8MABp2x
         DY5fgoz4VGJiZZs+HBS6BE2S9RVnVMc+z/0TsCI9MLSM4Gb151affBoh3dNE2K6tE3Ub
         6Vuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jdEzrVvS7er6a3IlsJnCTgJPsgC3VSLy9Xk054XJvXM=;
        fh=9s1ePjdr7inS9X7HgFypCCGF1k7hU1Wo126h8sxKarE=;
        b=Cm6F6aFlFtt4qp+SMdBKYBKpYbfeQN6S3ybUL9yg+nHeZVKaC0REy5m7PhKlRAzI++
         JBz76DBIePJwhiHFtq6FLa7laebAistLZsrWZJop86/EiHmKehg9essjmK4cxiLItCUd
         VP+JS7ZpMPnDt/pQNuZHE+6jP2r9HdrwZr7b+caV6WHppxU8QnXOYf67fzKW/LFHfk2d
         YOKsD81TP0NVT27MFwUyb2VXwoHxd14n3Me/a45LL+g6CMQNVdgp3KyQ/YgYfAZOOiQK
         ZWCiSuPLmlHzavgwR01IQEiwgrMS/aOvSarc/yS8cPPf1lOhDfJQ4ABEVjAR6csfDJh5
         RaQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793281788; x=1793886588; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jdEzrVvS7er6a3IlsJnCTgJPsgC3VSLy9Xk054XJvXM=;
        b=CWV5z5FOFmpz4/rZ0iBri3mEORYKdK5sUx0gxqPpGl+YHGOu40V1Z38jQpOQUFOts/
         82omxjEaspaZos0w8KXHBORshZZby/eQ15qwX4XUUo66p7blyjSzhhfz6J61T8K8VFAp
         PYRwll0MS5PwVyzP9oBWRU8WWQfwwEZkwyXv2Q438LrNcnBfYfrmIIZRblAU8FxYFNi2
         eWf0wonUPZQrsS66KS0Ir3jpxQAVDQvZjtLYUgsfqO0un1Zn8EPDfO+qfsiqW7W03PbE
         ZGmqVlOk3J0X4W2qO+ho79HwxDtxeXBlee43H9SrG7LH6UlqmWkRzQxJBwqN4ry/WXzF
         KTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281788; x=1793886588;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jdEzrVvS7er6a3IlsJnCTgJPsgC3VSLy9Xk054XJvXM=;
        b=d+X8WPE2AqG/+e5mlitGx76nMTeD9iegQeE8hagqIGQfPYmlYWvQ7z5b3bAS0QGb/d
         dCe3iSd80GEqiPLGN5w6wjC1GuTBdpAXUUcZeJRqOl+/uSgllnZK1g3PrraBb/06PkQq
         hQzVDc85ENCoMJ3g2q5nrsdchqm6PrWslh1Od7C1oOMx0p9HqW9upz/0EuNlukLmfJQ9
         2RbsEnU6yGnQkevbioTeFLb3ME7fDZ79qG4MG3Fj+os0dEhzHBGjP958GtHRTH7rDd5V
         Q9/PVHSm0u7uXRfXseKCCO+8MyY1xiI5gaX++ELStNH2jxMBVJBs57Je7fLCvFQTRgW6
         +E0w==
X-Forwarded-Encrypted: i=1; AKwUvBzVPaGoMer5ydKlt5ikQqKV7TE4DoxiJVnGGyhopOG4f3T9Vg39RnnJTRMfrmCDLvXy8pg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjNra72aA/ktw93Mi3VFiGrbw3d4ltQmH3dJczKpuoAdObqLio
	3bigKILio70heTAroz73gaLQTAx2kJuSjbIBYbwX3i7Z6G/FNnA7O/KEcbDlRfHBiZXOLM3JH3M
	5yNiF71/Twro2Um9Rh407n19tKGIsLHMD0M9SafOh
X-Gm-Gg: AYBFou2eVhxSTMYZwpUJMNFBe4ruQfv3W5ImueyaMrRnUcJXfUHqL2c8PjKcghgiex4
	bZ8FDEHhuv1Jl+8C71k8/MPdCTDA0Z0Mg4UBYlCEdogU3/j4F3s3KqON3mjwdt2O/D4IFqa1ZET
	pAqgHUK161X+oaEKnrKy2VGwTUPJsFh1dk3Kp5GKX+Ll7USUuCo1crO7WDiA3jAzRhSYFkyrIOV
	JwDyvtPwGbyG+9TSU2R9WstHM0uJzxWaGSuQSoxUgFg7UKRKT4ljqxrS5IYXJIOLLoxqVDGtuCQ
	Du7Vyi6StFVXw7GcaIFnQGsWrG5MD4bM0eevrsWr0WNxFhUWdk1nky8k1tYI8c3PANW8fJVo1X4
	l7t/jmIs6h/VbGK7OoOmfYUL1BJ4mBIMAhggOuEUZ389ZU1hIzsMbcQ0wJ4xWI7d+hA==
X-Received: by 2002:a05:622a:394:b0:536:702c:f8e4 with SMTP id
 d75a77b69052e-53fcc9c38e1mr83446311cf.49.1793281786016; Thu, 29 Oct 2026
 06:49:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 06:49:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261023172347.88443-1-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-31-5dd1dc6c660a@google.com> <20261023172347.88443-1-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 06:49:44 -0700
X-Gm-Features: AclHuK98-PJmC38q62LJKPyoT2Xn1t02jBqXVrJ0iSGV7iV-HBBvt2AVL4ugH5Y
Message-ID: <CAEvNRgEsGrhrRk2DcbrMNY3zWko_eXP3-FA1dGRSGYphQtBpXQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 31/50] KVM: guest_memfd: Support getting PFNs for
 stage 2 from providers
To: Fred Griffoul <griffoul@gmail.com>
Cc: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexey Kardashevskiy <aik@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Connor Williamson <connordw@amazon.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
	David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
	Gregory Price <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jianxiong Gao <jxgao@google.com>, Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
	John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, Michael Roth <michael.roth@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tarun Sahu <tarunsahu@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Tycho Andersen <tycho@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

>> +	int (*get_pfn)(void *provider, pgoff_t index, unsigned long *pfn,
>> +		       int *max_order);
>
> Should get_pfn() also return attributes of the frame? Only the provider
> knows them, and every mapping of the frame has to follow them. Two
> examples:
>

I agree with you on this, we need to let the provider tell guest_memfd
(and IOMMU) more about the PFN being returned.

> - Read only. A provider may lend a page that the guest can read but not
>   write. I know you dropped this from the sample to keep things simple,
>   but without it guest_memfd maps every frame writable, and there is no
>   other way to make a guest_memfd page read only.
>

I guess read-only would be the equivalent of !VM_WRITE in the VMA world,
yes I think that should be supported.

Other than read-only VFIO would need something like "cacheable" so KVM
knows to map MMIO as uncacheable.

> - Aliased. The frame is also reachable somewhere else, e.g. a ring
>   shared with a device. Such a frame must not become private; see my
>   reply to 34/50.
>

Are we defining "aliased" as something that will never change once
the provider considers the memory in-use by guest_memfd?

Actually, I guess the question applies to read-only-ness as well.

I hope we can say these attributes will never change once the memory is
considered in-use by guest_memfd. Otherwise, I think we'd need

+ Some equivalent for folio_lock() to at least hold these attributes
  constant until the mapping happens
+ Perhaps some other callback like .can_convert_private() for the
  provider to dynamically query.

I'd rather aliased be something along the lines of
"cannot_convert_private" (a concept closer to how guest_memfd should
handle the information).


Glad that we're converging, thank you for doing the rebase!

> A u32 of flags, with 0 for today's behaviour, would cover both and
> leave room for more later.
>
> Fred
