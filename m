Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899E19D8A8
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173785; cv=none; b=Dts0GVPQwloGkQxSJOTZOAhv6uhprYMH1MA7WyL9ct4x5aqBsKhdoNJkLo79c08+el/toVZ4vhJ/heC00VhgGm0mRZMSTVEm4LOKP6onXYmbNr0fIsBoOyaMahEx+oFHw+Byi1t4BmCDNg8O3LMcijxPeQyKghlsYNsnnupZDx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173785; c=relaxed/simple;
	bh=qLskmc5gvD/9BaiuXAI/iFKmnqqzh0h9QIDjBTZ0PXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ioY7gkNbJ4EAdkKFqfJ6CIdhJjf2GTINNwDE6aId592/eCnXBdzY2mNsA8QYOvERhTp8pCp2q5LzvCQqP13yp7bmnGLqoeX5RMTPA8pnqIw+2W2Q6gCOnVdAaGpsE5SJ1JsJQ6rdyibklLVl0I3KFf+EkjkZwgQB69C0nXG4okY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2nEmZ94; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2nEmZ94"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c2c98c1be2so42358505ad.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 17:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782173784; x=1782778584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ob/JScNjh/WWoydgNSe9txnAf4hRBZPGssYHA/PqDQI=;
        b=n2nEmZ94mxvA+lai+6Nh0ZiBIJzl7a/IMtTQRqW4JZZkk8uFufvvOREjC752eox1rF
         7xkL2j0126JGecyQ5I/7SF3iHMBHZePNgbmQJWtqMQawBYe1yrLJ7iTe/42qNR6/cAae
         09xvS6I0y5JnNS2+avc3np7u1mp0c09wv3dl93dH29PbAu2nPZNbKGogZ1prznqQ5lhp
         fdcTeignOfeIsdVTeiXj3Wyv/BR2syKrUHLeQcdrF0c3BjOnU1lMkxuV1MzsbPtCX7Tz
         PrYtJcs5aOabpuMh7oysafuGVSIcr0iupyunnP2E8sfdkw8GBkrtm2n+xqNvEEurt+Xf
         ogRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782173784; x=1782778584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob/JScNjh/WWoydgNSe9txnAf4hRBZPGssYHA/PqDQI=;
        b=F0Z/FdXageRIYCWEXT2RsxDoYYrpyx5f6/wwp2Jxw/iCurQH1+E+OS+DFKKoiKfFSJ
         DUaJKngRkENRmX3Qn5xFVxL65PLy/SLw2wj1Yz+lMDBRedvUQXbQiK84Wmskf1qmbaJY
         NIQoqkfUWn4cAzu8xkxMpQJxSdKIvbs9UqodHGKEjoEYam2WD/FLuWgvHrUeqcWVDDnd
         cSl96J9/z40Vk1bnA0cGAnIP9Gyd6iEETos/cdD7KvTftpWvWvDRGDiw97ZMsk4DjSsT
         YDMiVyngOBtUi66R3qjNJvreT+sO9nlRtfCbjpBRqiQuxaEqiB3hqIgfZPet5lKP0H51
         R6Pg==
X-Forwarded-Encrypted: i=1; AHgh+RoLtIvwkDalnAnneg4i31lXSeTVOrp+2IvLBRNpN0LrD5ik+nyAygssRPM3ByL7AhSSZZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbyH2je3SixTRD/f5HRdhwXKc/FUv/jJTobD+mUz1mgsQsivjF
	4GnJ4IMvejzfg6h5Nm0gcFuRSbK+BuMh8P445NnNQU2J4KIF/YyBeYBj1qxoDSYgBsk68w3Arul
	VmjP6kA==
X-Received: from plbkx8.prod.google.com ([2002:a17:902:f948:b0:2bd:106:8ad0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da90:b0:2c7:c3a8:560b
 with SMTP id d9443c01a7336-2c7c3b7a5femr16356295ad.18.1782173782987; Mon, 22
 Jun 2026 17:16:22 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:16:22 -0700
In-Reply-To: <8e53844c-f2f8-4a4b-bf72-f3140c170d43@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com> <8e53844c-f2f8-4a4b-bf72-f3140c170d43@gmail.com>
Message-ID: <ajnQVkLvFl_lMuGB@google.com>
Subject: Re: [PATCH v8 05/46] KVM: Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable
From: Sean Christopherson <seanjc@google.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 19, 2026, Julian Braha wrote:
> Hi Ackerley,
> 
> On 6/19/26 01:31, Ackerley Tng via B4 Relay wrote:
> 
> >  config KVM_VM_MEMORY_ATTRIBUTES
> > -	bool
> > +	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
> > +	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
> 
> Sorry for the style nitpick, but could you keep the type and prompt as
> the first attribute in the Kconfig option definition (like the other
> options do)?

No need to be sorry, I've no idea why I put the "depends" first.  I don't even
know if that qualifies as a nit :-)

Ackerley, if you can provide your SoB (for Fuad's feedback), I can fixup when
applying (assuming nothing else necessitates v9).
