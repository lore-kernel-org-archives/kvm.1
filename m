Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB613C1406
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310731; cv=pass; b=gvRPAuTAcXeCEKsd3vLzD6hK6rnj9PzZe4C2QECBSk05d47dQhZgosOr7hb4MHc+SQYry1nYV/qGFomkOymmyJfTPBuDVbZ173AtpMVfx32FmBRwn37Eaq/d6Gid9LIYPjT63fv0RH4X+KdN33s+J+dH5cmxNwzQegUqsiWPpT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310731; c=relaxed/simple;
	bh=S43KLHfWZf4rr+LSchiMooKQ2vnBu5Vtd0C00yl/idE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbTPXU1ryvwlb6LHhX+9IOU/grQw4pnJ5BS2eJ+eYuQclIdDMGJIxQrne67aGQYOCjXpuBxF201JizP8CCmeNrG9l4go4NQCoa4oryWp9AcWFIWW2FS7Jh853mvPIosNW70R1+KNiuqdxZFffekonxM/Mpz9v1NLeGw1tlNMzJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=df3sqHyt; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="df3sqHyt"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13986d61b4eso2706735c88.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 07:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782310727; cv=none;
        d=google.com; s=arc-20240605;
        b=ZfMhhil61i4HX5YvZhB2eyAJSddHTuTI6pm54POq2p0loDMC0vo3PO4HB12EimkjGH
         puWg1bcbq/h7tkVJwJ9QgCIX7nEZownWdMEmtAYvg6zqHiMNco1kLrjpM0BnTJelxGcN
         KAzf5kB/U/Ah6GONiOXQXSiHXmWAUQAqvLnS11rIKH1+5W3TWLX5OmAVrKFIn33RmX+E
         h4srQdSuCB8Ee/MKtB8YIlyVkGOMx+yXz63rsU9HrhwHLqqPpsg2RKR9rCjqL+TdakNP
         uT3KkLbuK8NYP601yVxEVWjc4NfI7uzBbVG3bhXBdNpps3Fkxu4T4ObbfTNZObgZlSwV
         Yz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ucZ6vleVNv7XMe9m+p1ud+LWxJsaO5xEtX2/mrf+WGU=;
        fh=+FZMXagWLchR2Dmv/LjtKu5DOwNrvquktB0g5IPiU24=;
        b=HUve0I7digCTGLfXiNWELq68fZUoyqVOPgdKySvJXK794Xs3c+TVVQSIdYJDTptcXo
         LLu0F36VUgnWL9zCOttXE75TYMXy7aYaP6fHe9zpZMCUPqiBLZnm0aiDJ4Zfr4JckWgx
         hSWTi7JG7z5iriR2l5oP48gVWsKWX0+ieMYisGZIu3dpfPJsYIYXe9NykstKMzkNFHSK
         4tDjg/sKLjevAGpLnxlIJBHaNWdnntl5/Q42XjAKMf1g1/xk4F1IS5GoVxXz1+zTY3rs
         Dh0kjHpAvxTIE89z1yo6yHye0GsfSfi3t3rzaLMRkCTie+Tm61srBbT3TiC0ipjm70/N
         xzXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782310727; x=1782915527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucZ6vleVNv7XMe9m+p1ud+LWxJsaO5xEtX2/mrf+WGU=;
        b=df3sqHytMdVQfm8AoVQf0XDsZFlP86k7xtk4HCgprtM4Sn9s7OAXQylD/qcfp/Ep9r
         0t9p/fnfAiUBS/iQBNEPTdSrMRAMDtcJP1OwM4knL5F42tn5UEehXedN8s4JXkHtRTZK
         VOqr9xe3z7xacVEAVUp0J8cETm9/thUkrXIXkD9i85dk8hbcnwljADl4eLtMcNHJUdq7
         Y1FOh+re6oPej1vzugspLX8LP1l+xmKh7xNSPDHoAHZvo10EYqTi2dcHjOsy0YYdRivn
         fRKFRvQUauDv62EyXbk7hRSdU8O/51XpfJwHFWCzmVQRJkPuzoLRk3OrekIrJxhOujO3
         IjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310727; x=1782915527;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucZ6vleVNv7XMe9m+p1ud+LWxJsaO5xEtX2/mrf+WGU=;
        b=tWVS7hq5KCPXQAUKgLJR3uv30zfxsH3o8mmjm9GnqBAS72OgvEHm+LJJWsqRgGgm2Y
         VYO0q32nc/ePNoaPcgENSJBucL8OhEabzidTheKPltzqqpoDhhWPgPXcrgvtie3//ibP
         fS/ikKkyOlw/qsoCea2dPfj7B3btO1AfNdPXDJWTHaqBP1Dy29P8A35aklFCv2AxvFBH
         eocoCfosuWHQC3cvs1cAb86NpENQ0VOjuE6AT5REf+POjbNaGY/396T7iWzEdJhAlbAt
         lJ9ia+J04qXKLn7QcW1EKrcjKTXlK7AP5Sl0NEr5GPhOEcw4ToJEByzGRMA/EZfK8Nk8
         QV+w==
X-Forwarded-Encrypted: i=1; AFNElJ8Q9prbtznM0mzx+Bw6U4MFGupuJ4FwtvTXri9XI5J11bHQtYQhBBfVNnF2MtC7zgu7bCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+UjPQF9ixzp67U4pG7FPwMy4ekrZmtJ3t5GDHXXHixf3bNQ1
	3X80Ahr+Cy23kSA+Q6K8QbN6CgioLuT2fSe75HOgyubKv2ScuIGT+RdE9RDQPpPQMAUlATQAsSc
	ZjcymyUSzLmYZFFrv0o1HRYKzSWBcGB5VamnM1cHq
X-Gm-Gg: AfdE7cnGBwPniweGEz1DxwneW7XuuMR2f+DUib/SXCcQcB5lnJ8yRYbf5VcJD1qaQCj
	kIFCb2YUKWyYwfF/Vl0P4g0QvAZfeFCmmb7+eOtjpxZSGvFb0O1PlRyZf9zjLtwth83LiZ2kJ/6
	Q5yMyzGHW0aE0r5pF2s0cy1FyMgt7mPjQ/xhUgeNPUIQEAGYcSuXR0ygriQ6MScrOQPkngqG2ql
	E5CRQmSlqY734ug2A45Dqb1gdpoSPmsrk2GQAgWvD/tDrIKDF5JenBYkedoxSn3wKsHUV30Ll/y
	j2vgvhjWYgjOuEIxbovE8EgTUU8h
X-Received: by 2002:a05:7022:43a0:b0:12d:de3e:86a8 with SMTP id
 a92af1059eb24-139ad72bfe4mr15983384c88.38.1782310725876; Wed, 24 Jun 2026
 07:18:45 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 07:18:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 07:18:44 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <3ec15992-2a29-434b-8c99-8b86bfcf007e@arm.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-8-9d2959357853@google.com>
 <CA+EHjTw6x-mxDnJjnhE-6SV73tMrb0paKDTtOC2j6zJ1fXZDLA@mail.gmail.com>
 <CA+EHjTxu32nQ+vPV7Zmcw76_-V4g2_g=P_UzRnnO2dP1PFO2ww@mail.gmail.com> <3ec15992-2a29-434b-8c99-8b86bfcf007e@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 07:18:44 -0700
X-Gm-Features: AVVi8CeUzt8nV1nzvS6dw32sjloWQ_ALAuG02W0rgNOvY8pSNnpach_kfV-0O1g
Message-ID: <CAEvNRgEKB0FhD=qhyX=0m2o+d02Jz6n6njdbFmjyiUpK3Up-4Q@mail.gmail.com>
Subject: Re: [PATCH v8 08/46] KVM: Provide generic interface for checking
 memory private/shared status
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
Content-Type: text/plain; charset="UTF-8"

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>
> [...snip...]
>
>>>> @@ -2546,7 +2546,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>>>>   bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>>>>                                           struct kvm_gfn_range *range);
>>>>
>>>> -static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>>> +static inline bool kvm_vm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>
>> Should have read the Sashiko review first, but where is this used?
>> It's not used at all in this series...
>
> See below:
>
>>
>> /fuad
>>
>>>>   {
>>>>          return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
>>>>   }
>>>> @@ -2557,6 +2557,16 @@ static inline bool kvm_mem_range_is_private(struct kvm *kvm, gfn_t start,
>>>>                                                    KVM_MEMORY_ATTRIBUTE_PRIVATE,
>>>>                                                    KVM_MEMORY_ATTRIBUTE_PRIVATE);
>>>>   }
>>>> +#endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>>>> +
>>>> +#ifdef kvm_arch_has_private_mem
>>>> +typedef bool (kvm_mem_is_private_t)(struct kvm *kvm, gfn_t gfn);
>>>> +DECLARE_STATIC_CALL(__kvm_mem_is_private, kvm_mem_is_private_t);
>>>> +
>>>> +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>>> +{
>>>> +       return static_call(__kvm_mem_is_private)(kvm, gfn);
>>>> +}
>>>>   #else
>>>>   static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>>>   {
>>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>>> index 6669f1477013c..8b238e461b854 100644
>>>> --- a/virt/kvm/kvm_main.c
>>>> +++ b/virt/kvm/kvm_main.c
>>>> @@ -2627,6 +2627,20 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
>>>>   }
>>>>   #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>>>>
>>>> +#ifdef kvm_arch_has_private_mem
>>>> +DEFINE_STATIC_CALL_RET0(__kvm_mem_is_private, kvm_mem_is_private_t);
>>>> +EXPORT_STATIC_CALL_GPL(__kvm_mem_is_private);
>>>> +
>>>> +static void kvm_init_memory_attributes(void)
>>>> +{
>>>> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>>> +       static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
>>>> +#endif
>>>> +}
>
>
> Here ^^ as the static call update ?
>
>
> Suzuki

Thanks Suzuki, it is used here. kvm_mem_is_private() was and still is
the function used to check if some gfn is private or shared. Hence, in
this patch, the usages of kvm_mem_is_private() were not
updated. Instead, kvm_mem_is_private() is now set up as a static call,
and the static call is hard-wired to kvm_vm_mem_is_private() in this
patch.

In the later wiring patch, all the places where attributes are looked up
are updated all at once: if conversion enabled, take gmem route, else
take VM route.

kvm_mem_is_private() is special in that the if-else is done at KVM load
time rather than runtime, and I believe that's for performance reasons
since this is checked quite often from the KVM fault handling code.

Buut I think perhaps Fuad was referring to kvm_mem_range_is_private(),
which is indeed not used anywhere. Binbin also asked about this, I think
we should drop kvm_mem_range_is_private(). My reply to Binbin is at [1].

[1] https://lore.kernel.org/all/CAEvNRgGbBcrX5Fw3vNTsTOBNC=Ypi=9-S07674yPxLU9i4akjA@mail.gmail.com/
