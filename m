Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDDE3921C3
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650363; cv=pass; b=gM77JhpPE+/rFltEGsnWVTcNT6qZ/kiYKdYOlC9Cu3w1DRiYfF683L2MEsdPXrbBmXqOdQ2rikdyB6sj7gR9evZGTH1qEkonoKC56W9NnstMitv2OEVJ34mulU/U3K38ptkKWdnbN32EjYmOddZh1de6PXSOmCUfe3oFph8A/HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650363; c=relaxed/simple;
	bh=JmR/CB4xNI+jcLTEmH96suuAwtFrH/css1uIDKyeEDE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4jpds9GbGevkjEeFasVYmEqMEaVISLTU5yqYpNfNoT13t8WgM1lUBmAk+SjASOhArrm335Qtug+MUOl/wvWK+HEVVmAIk8cijJTcwwOS3/TAzZEebl4+CKPmLgKFewq4dEmayRgMb1hAtuEYcBWUcfSztvy3fn6wAOtM5GNl0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=COhK4qYv; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COhK4qYv"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c928bf172so33353991cf.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 02:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787650360; cv=none;
        d=google.com; s=arc-20260327;
        b=Yv1lA6hE4KuAfuss3DXwbEVikuy+j6NCJ9I6sfNBxS7Dkfib+kV//0ol/FvKEO2rNx
         ZXMskfKhoUbUZJsWO437mbVVIJkU5dOwY3d736ikXjuhgcyfVmss2i9LTlBA2WqZQBtC
         EADrm+pfJ+F8nx/74mq7Wm671oJNg3H5vCj7/V4pUl/SzUVJxQt6ID+myuQ4AY/kzaaC
         e2swXdBxv8VzqXFU5JQKwx1BYKXdbOH4CFMLHEwC4FM5Dcw71yBaEjoL6JFHeXOMX/GJ
         5uuKy8eXh9Bjh7nIj2pwLClzxxjoYzD/8ZuqEZhNeRmbMut1ss7/81qBVclBQIcrq7jv
         lGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uGYcelPQ9NcToBmCcA1Af+U2AVoIV7KPe08HWX7sjzg=;
        fh=Jq/dL+Y2LV5w9i8WLXa8oQAQRhI87ifGRVCcs1c/HCs=;
        b=qJZwAC4hb8Kg1kLRl9X3LCh9Uumii8p555r9dOTfHsZaFkjsqtIdvXozV8k30X3W+U
         NltVylZ1DpokRJIvCZzER2C7zg6Km7i/CnvTvygYhyRtrWKrR8N81rhKYxnTarcEAgMQ
         ysJnCuYRIYUk5hF9txqMnyUeRbONJVLw7cOa1ppdxzDwS4Rr4G+FbhkSPO+jP1XPt0VW
         vxGjHElCcu3IvQnA9DPqs6EbAPcj7FHHCn+/WRoAwhjEjA3eB1MmPuBMA1jXg56kfUca
         5zGMGhgUDOazPLJ1OOhAz3dGKqGgfC+EQnp2im9r0LWoWKzbYPVRRDppPkAFrYsecuLd
         hxUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787650360; x=1788255160; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uGYcelPQ9NcToBmCcA1Af+U2AVoIV7KPe08HWX7sjzg=;
        b=COhK4qYvOoJJr+D43V/gT5xoxYixhbuEW3sQWFOSU/YW0eMfUsn7zourAB5zEVeqU4
         0Z+t6WDhX1//5aq5h0a//I/JnlYDqcQSDi1bKpFWXYtKmMuCMMiOCvWm5LDq/Oxlf25r
         ZzNOAZyfhlRKJEan2HpB3IaWqkW52eWyIopB7wRfq9X6476P7foLCSa6fJOK+0VuKbpd
         vUbIsefHSCFqqq3++sDiLAKYscX/2UWlR712PtWS5O/PaQbqx7z0uNmkyw/E9QcvhuBV
         cEJZj0GWoUq+wO8//74+Kk1TD8EkZMoU6TI5qJIDroligGGwhyYEruhOX9xUkiRJSIrv
         UYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650360; x=1788255160;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uGYcelPQ9NcToBmCcA1Af+U2AVoIV7KPe08HWX7sjzg=;
        b=moWYHT8X30iGkvAgGAVzIFMv+T11pde1TX20oS6KGvOq1FlRUq08ZTJf1TacvgEBmT
         poY9NQiksX+U+pD4xGmwD89uFVgvHYKyfSCg5LtdBJcMVTqoA61q0SB+hV4EJ9V+BML5
         z4e9g0tVIPTUrwCgQ/VlLHgeeIe8+FzgwekcNraOy6+K8w7u4oOJkvWAyYqjRgSWe3X0
         LS0iSjbkTA4Pdcub9DkYCsBmuYeKDxDlMGaTwm7VzJWFp1XffO3kWnJ2bqcRkOTA3UM8
         Rvy7V6AD3cgvEsujHmhoGKwKTIrqcXs6Vr8I49DmRggjV6gV6IDuzEnmiNUOKPnp+/+X
         wdRA==
X-Forwarded-Encrypted: i=1; AHgh+RpB3BmZGk+To/XUxw1yMWON80Y5323GQPqQXLb09bt3bHq3xNirPnd3l8ENjcQQZQ5VSRM=@vger.kernel.org
X-Gm-Message-State: AFuF++nQvtL1n9dTZoEK4O0UiD/ByVEsEBW/AVE0eGz7anhc3Nye+Def
	tXFCEHTf9M8D2rgTVrynOn7+XhSIPo6QKtczdX/wYh+y+3te5jck04/kOh0Ddt7f8uWTXJi08Ai
	olV2VY/CEZHzI/VI2yBfpHZEvGMBzC/KohKurl1V5
X-Gm-Gg: AR+sD10ATWoTpy8Rfff7v7ag5UhYGTIaFT07pd/OvNeio7ZUsgEvDkl+agzd3WiDUuD
	ZcEC+gTCuPwB7vDPLuqYfvCqDZk6oTnFBfzdsLIXvpBqAVxYomMG7sO4x65H1O8eDMfkRpqrG7N
	Rm/AWyEYaKqrI3fOY1b8qs5406q+ZzsaSDirsaYfNw5wXqv/QnxyF8S1TugUxC8wPBpumXZMoDv
	Cj3wHh9RfzLfydwBacGTHaeqruQDhDcGikMVEuJIexC4dsFpE13j4XdKco9I35BxjX2Z3cTLUXH
	qoxFxrGyBepnU8+SaL2ScRo8QQOAu3aD6auSpvgDD9WYSUYoLLFKXJlldwCX8rm2j/YFZUSrvPa
	hVicxoP8wDCmWcy4BJUkjrSQ/wmUa8zU=
X-Received: by 2002:ac8:5a8f:0:b0:51c:1eef:4fb6 with SMTP id
 d75a77b69052e-52df572d04fmr316920051cf.10.1787650359267; Tue, 25 Aug 2026
 02:32:39 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 02:32:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 02:32:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aohEz_1JFVDtlSnE@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-40-2fc18ee6d3ba@google.com>
 <fe1c6359-7371-4ccd-9807-1d81c160d12b@intel.com> <aohEz_1JFVDtlSnE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Aug 2026 02:32:38 -0700
X-Gm-Features: AcwNN1WsNauanv_gwVuUewgYIPtJyz0xA7nijfgKendDL3I7JaxAnreMY2X_gzc
Message-ID: <CAEvNRgF8XE2Xsn-g3qzPxcdfLdvJEc1FZw9LQ+deeXsFpdZsOg@mail.gmail.com>
Subject: Re: [PATCH v10 40/41] KVM: selftests: Update private_mem_conversions_test
 to mmap() guest_memfd
To: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Aug 21, 2026, Xiaoyao Li wrote:
>> On 8/8/2026 5:53 AM, Ackerley Tng via B4 Relay wrote:
>> > From: Ackerley Tng<ackerleytng@google.com>
>> >
>> > Update the private memory conversions selftest to also test conversions
>> > that are done "in-place" via per-guest_memfd memory attributes. In-place
>> > conversions require the host to be able to mmap() the guest_memfd so that
>> > the host and guest can share the same backing physical memory.
>> >
>> > This includes several updates, that are conditioned on the system
>> > supporting per-guest_memfd attributes (kvm_has_gmem_attributes):
>> >
>> > 1. Set up guest_memfd requesting MMAP and INIT_SHARED.
>>
>> If I understand correctly, even with in-place gmem, the model that shared
>> memory comes from the userspace_addr and private memory comes from gmem can
>> still work without passing GUEST_MEMFD_FLAG_MMAP flag.
>>
>> Since this model is not prohibited by KVM. I think we should keep the
>> testcase for this model to ensure test coverage?
>
> +1.  Deprecated doesn't mean unsupported.

The original test case was for non-in-place conversion, which wasn't
removed, it still passes.

Is the ask to also test, under kvm_has_gmem_attributes aka
gmem_in_place_conversion, to have guest_memfd used as purely for private
memory and have shared memory taken from somewhere else completely?

I can rephrase the changelog and change the code to clarify that this
patch is meant to specifically test in-place conversion with MMAP, the
intended usage of in-place conversions.

The ask to test gmem for private and something else for shared seems
like a different test that can be added separately, perhaps in a
follow-up series?
