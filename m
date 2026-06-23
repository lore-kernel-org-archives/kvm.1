Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BB3769F7
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177892; cv=none; b=Pv1laW589y2qc7w25fMYi/vnjreQDcXNyHtRh3JbtanhfY1XHV9xhO+957UDihDD9M1oT/BNWmSAVPiHSoWAycNyjYzdKiPLs+rkLnsmwoFbTtKUGGmDVbMFf9XpeA8VavA509Bg2jy7P6i7olSGztABLF3N4Yy75mJVjeRFjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177892; c=relaxed/simple;
	bh=efM0IjSTL/YXtmhicxOoTytgoByW6YhmiFqAN8KcL4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uNX58QwzTBLqoI5pKz0WYoyvXk+5qY0FyPSUzYiaOSRqnNRrB2eoppd7LP4QImkpxarGC3rVyZ+Hj2tqqiv7+V+kXLDZiHVbQtUEy6P5GBXQYCH2RVW906ql0oarijNOAVqVSiIGVtgRSZJTC8mW8Xai0ptX3zc6H2MKSWljASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NMiNPavW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMiNPavW"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37c648d3ab9so3164671a91.3
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782177891; x=1782782691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cP6zcq/A46NjpXBVqyG7Tuag7/oGP09m6JyCX4S5UME=;
        b=NMiNPavWhHJuKSPv6hgQqw0ctKxy7SY16NqzlDymVBTrvRYXDuRo3PsG2EhMcF/Rv5
         YJSI9B0/4MHgoBpEDq8yaQNn1Vzi0azDN8N1/wp2i5tCpUCiX8ZaFeW0bmugKI+8f+Uj
         CtorOuyxlaY16RGpUiJVY7QFyPWU4jOay5NtmpHY9eZz3FrYzQib2RJyhgKNtg1JrvD7
         gHapO/sjN/uxRNyUuWHnCnfKboxqK2VdWL+ehZRz6A2OgzzWcUKod5npP9lZzW3ZO5TX
         zWpqSGGDU913UlSOaCJYe3PHC4Kr6A7aQCVg+jOPTGjXbVyMWTDOQqqma4ZiDOdpJOnE
         Ji6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782177891; x=1782782691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cP6zcq/A46NjpXBVqyG7Tuag7/oGP09m6JyCX4S5UME=;
        b=UuzWG9+bWnTS3Y0bq7MwOULleb+mMJcr/2of84Lwhzunq/SmufwKIfrC/ku8rN+QAB
         sOaoHk/WWUa8OgqKyDH3+/XkS8EpibZ57BSh/U/YqHYFCUIg9MZJ2eJL4aCZbahbosBy
         YNWqSIFstNHYtry6jbCUQXV9d/fCClLLEZbKNNC1M5xM0q+8bTheITHFpGVBtOc2Dpr9
         DBtmHztKyWa4klW5h3frCpX5VNBXUev8MV4wEl9d5W0ZI0rvrIlVCRAIIXvsJM3sFSTi
         hx5KcNVgqiFe2HiZ1Sm04ermzYwTl/ChAzoi7z+5iF40jf3Q8Zbcirv/3VodJuxCKEjp
         Rymg==
X-Forwarded-Encrypted: i=1; AHgh+Rpr6j7YzjwHHJ/KQZBOW04zDelJw2Nyewcsf/J+IbSpsxpnW2CiyIhh1vMhfpMR7EENt0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wAhqsiAaqb5xJVhvJjh7lHoTZMjtS55xm3oOvkvLRdT4ITms
	TEfN1L/r13c2YjU3hfPMLBOxNsKDbac6DiaMPeCVsPenHYVBmzBrxZEoz5gzY4lu880CLGtojz1
	kRuh9+g==
X-Received: from pjbbf6.prod.google.com ([2002:a17:90b:b06:b0:37d:8595:7a08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2707:b0:366:3ac:f730
 with SMTP id 98e67ed59e1d1-37d160feaa4mr19637357a91.25.1782177890287; Mon, 22
 Jun 2026 18:24:50 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:24:49 -0700
In-Reply-To: <CA+EHjTyj-JdW8H0ii2j3dayqnT2s3VV+brSG++p335=FGd2GXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-23-9d2959357853@google.com> <CA+EHjTyj-JdW8H0ii2j3dayqnT2s3VV+brSG++p335=FGd2GXg@mail.gmail.com>
Message-ID: <ajngYb3aNTvtXkwl@google.com>
Subject: Re: [PATCH v8 23/46] KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
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

On Fri, Jun 19, 2026, Fuad Tabba wrote:
> nit: why does it have Sean's SoB?

Heh, I had the same question at first.  It's because I tweaked the module param
name to gmem_in_place_conversion, and so updated this patch and sent that version
to Ackerley off-list.  Ackerley's SoB really should come last in this case, even
though it creates a somewhat weird SoB chain given the author.
