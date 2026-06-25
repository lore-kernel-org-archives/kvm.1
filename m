Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B42F8EA0
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370843; cv=pass; b=otdroHGVr4pRzdtNRS3xfwTyJROnTA2ByraWYP8W1A2TpU9HAcB1dqVrMlRLyTBltrvH9vavUH3Xyjx3jQ5HuyS8bBVH0cdhRn00BYlWAOHiKEuaS3z6W9TGgJqqol7UCtqBtsql3/Ao9MKH2zh5Zp8h8rTgwuVuZQsGOL9gCFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370843; c=relaxed/simple;
	bh=7JJoQZtiGk7coUfKOMj2B/mrqYm3H457ckdZcSJc6Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHqomrMuYgRz00ka6RhAqPZ3/SUog3mWe7OPpxsmVu6rZo/9eCO/f9ZyuiV8T6PPIjhBGNgACcH8A5DHco2hYl78iqVovXH7sjYKFhKR8G+hBkw7Pqrab8ujkee89qWh5aS+GKRHmh1gRlenxJIaqho9+y/LdbdBkJWvb4FOuYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e48O1c61; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e48O1c61"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51765331535so123251cf.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 00:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782370841; cv=none;
        d=google.com; s=arc-20260327;
        b=lr/+Z5uFOOKoXDGfu11KowVyusyaCscngb5JAcZ6eflLU3K1EtD6wmIlJUmyU/r7wu
         QvAhhPtaUX12mTbYbpiVe1KJ+NvDG0yOp/voL4djxNEqJmQJxIHILHbeXWEiwgCsxYvS
         qDs5tN5Wi1quhU2aJj4bgUOtGL86r9IoS55c2YljF7hpm9u6SOC6AD3tqvNRn9cqQ4qp
         9M9bOUkkPhTMblApiH8BzrqYG9QlpdwoqI6S40A9ZN/El9pCiuwAyaHVPsdbOu81iYlX
         2DofetUOLiWKofXeG1s9zBfDN8bKOvxsgGwCmQCjG+rnKvc4E8tNsIrfyF1IpgWma0IX
         HwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7itwZj77OJzx0Nbk553L+ihvDTrBn0KieHsapLPAjLw=;
        fh=7W9t0+9h3C5i80ZemsPrSA1ia94/t0E7qAGA2VgVxLU=;
        b=ozwcImYKvmOfkQqijuE8B+Rk+PFlRUBhuruf+AOBqtUdHdmxkawjVI8L+csbZp2Syh
         f4SCqycbpWaw6qephb2f+JA2RUj0Ufk7/BVWaLM8DVEZi+mUhq8n6LilkRBwdHezjzBk
         mGW9wu3nvuSkKzIro2XdODmgpjztHX3crgw1GqC1wnV/q2ZWUffpraAXwAVINJea/OJC
         CdRmeyPTKYsbZbu2FnFVQdcA9FEt2s7asGpRYg/nGNT2U5wilr3R/L8Yyg1OfmhKcpXp
         uoMI8+cxHG4Ruy8MHYGnPToe9fg234GcxilBoftHRwVu0KjH1rSGjyi72rxmLXScS9sG
         NnXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782370841; x=1782975641; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7itwZj77OJzx0Nbk553L+ihvDTrBn0KieHsapLPAjLw=;
        b=e48O1c61mYFrJJ81UCyvgdSdCRMUrJWKUOd8+jsx9qjU68Zcoh1u+PQte4S45rUz81
         eHZ+XntRnpu4a7oXwrvix0ys07R6n29mCO7WpJ4pMesJZZmqTBYJl+mw9RP/9h9H/3t7
         nlt/rRYvNDdcxkMakXg5R/+fUu4LyB+2NsyWK/Ub2RPN9gHe6OWORyk8QxfYetkxXojt
         Mal9Rdm7KC5htW7jw1+QzZmtpFp9ZwNVJeqDtsTwZCigGmcA5X+V77yaB84hQCixhRlm
         SLw9tUwCXaIMpCJ1P69ROgK79CI6kSRUa+j/rsyWSdnxfVp8o2ecDTbc3X8XsT/ai109
         6eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370841; x=1782975641;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7itwZj77OJzx0Nbk553L+ihvDTrBn0KieHsapLPAjLw=;
        b=PLv9PZPDWh0vd204xa/aSq4f8PhkVHMXh9DiZ/RP2t1HtfH1oSZFMneISY+AG0vvUE
         yxEmpvGwXqPNIkZnKrmLylBMdYGy63f2CMDd/m0DLQ5XTdNdrprXxyf7jRLxFcSN/XF4
         Ejfaw2QXLerVd/P8b88Y5P5DONHCX81TKFrAbPjSQx/ey70zH2TO/4tfX4Hckar1/R0A
         WAyiEq9mB5vG9qg3KnqvFDAMg9mKwVIJJ0UYoZDJPf8cVZfr99MhUN2BpJcKDnlQgWjy
         rJV9dbrL8CkoU+z+ZRIDJ4m4KR3w/K0KFpWu3W1FcGqkU34hCQ0LsaOJHW4H1KKpqkGU
         /qVA==
X-Forwarded-Encrypted: i=1; AFNElJ/mEs5aLQxHzmXMo1xWrVpRmpESGLL5spnlnKDvt+Xp96ySIrtUXBCrmG58ZC0slhkR5e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIGalvx+DaXxKfLl0eqek0IgdEyvq+rMZZh6DDZCEOiuR+B3P
	mnMaWbd92v3d38gaxZ4v+yV4SF2PeKwts7GRNTsPBkEDMNHA9vPk2ouDBlkWfuTLvuMWRCQL2La
	F1mPjQpnEWxSfYbZUtC//KE+LCMDAnCJIWTxgKGZh
X-Gm-Gg: AfdE7ckYTA+ATV4Z2nk3iqK1eqReh6xvq/HajnVJyG+uw1RKGT927y1joS4ag6/ILHV
	IMQCuWmoejYARQPf7TmosMgKFA4/ThW7mn+rEBw7PD6FyocwvQiZCcNtyKs3IlFNuqtUS7UAWmd
	xBXiexakMnEC11yWJCc+2EYdrnptL1tkVZLouWr3DzoyoZCjPikZ5Ex52N6jah/PoMQHdCo/X8P
	rB5P9xBToxSCdU71O2RDyunpPZmmuKZCcJ9Ul0f4Stu/k5MA/ijaotH1eHCJlibQaLwdIKUWsyJ
	F80wl7Nz
X-Received: by 2002:a05:622a:53c4:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-51a6e9b5655mr7053121cf.2.1782370840588; Thu, 25 Jun 2026
 00:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-34-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-34-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 08:00:03 +0100
X-Gm-Features: AVVi8Ce3XGRWH9AR3rw80vlHynjgwNotwUVdlcJvIAaDUMJb2MBvPhhdMigDY2U
Message-ID: <CA+EHjTzR9r97Brau5KMmUf7UZvevmhpCKhTEt-9wT=0YXFLpFA@mail.gmail.com>
Subject: Re: [PATCH v8 34/46] KVM: selftests: Test conversion before allocation
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
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

On Fri, 19 Jun 2026 at 01:32, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Add two test cases to the guest_memfd conversions selftest to cover
> the scenario where a conversion is requested before any memory has been
> allocated in the guest_memfd region.
>
> The KVM_SET_MEMORY_ATTRIBUTES2 ioctl can be called on a memory region at
> any time. If the guest had not yet faulted in any pages for that region,
> the kernel must record the conversion request and apply the requested state
> when the pages are eventually allocated.
>
> The new tests cover both conversion directions.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  .../selftests/kvm/x86/guest_memfd_conversions_test.c       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 8e17d5c08aeb8..b43ac196330f1 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -265,6 +265,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
>  #undef combine
>  }
>
> +/*
> + * Test that even if there are no folios yet, conversion requests are recorded
> + * in guest_memfd.
> + */
> +GMEM_CONVERSION_TEST_INIT_SHARED(before_allocation_shared)
> +{
> +       test_convert_to_private(t, 0, 0, 'A');
> +}
> +
> +GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
> +{
> +       test_convert_to_shared(t, 0, 0, 'A', 'B');
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
