Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF7274B3B
	for <kvm@vger.kernel.org>; Mon,  9 Mar 2026 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773095526; cv=none; b=L9WBBkZ1iH0KNSeQ6skyQ0wvC1sDSW3VhxA/gIgcsTvPj7FERp269tWWGKE42B4YXx7At2CAX23FfiCO72tiSczvIonVg1bdCiZ7SCGNyzfJJIVM3iOqZ1PQqYjZnXTZsbqjnRUnAGkcwsobzg+2nIB7VLgzpP1drihMSLdgGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773095526; c=relaxed/simple;
	bh=Ka0jVISzipJAqHRkCGQhv2ocUOj57W+L55ihA8NY06k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7heGCbaqQvdbPM/wO9wK2caS9WjFAiCzN1jU4QXadFwDlt1Ycv2w3dSW6A5EqK5p4C1nwc//pq0M+Dxr6zhR/3O5l0+C/fOM3XGmZKlubS/WMScqnsDoBmofUcCoelhnlDyaLEMYlD+AdL4ynhqEpfEmHxpvCpYZzekIZQa2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DrCZceSZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DrCZceSZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aea4ebb048so5595ad.1
        for <kvm@vger.kernel.org>; Mon, 09 Mar 2026 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773095525; x=1773700325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBkcZ4vNzPnscp2wv/tDrm8if6LphvMnNawG/F/pvx8=;
        b=DrCZceSZargkLUVKGz53iBEIsfokL3DKF8MEcIHoWQo8g1C+7SPJZrQHYbY4QarKBp
         Y1r/0A7aq/Tw5zbsr91k0BbkncsWtPC5YGxrDpgBqtkzE6VvISUoN9NpO2muYEcxq1Xs
         073AOb2kWznabLjkl14HVSZ2hQLfjZEWpG7nwFUwelcZ3/0r5QAQFj1XR6Xe4y9OhCtV
         RcF6a2bGZUVv0hWalXgW/iccqjwrhgNdfoi1MDFCYF3cqYnaRuQeJ3RToSL//drD24zJ
         fEw+OhJKmK6dOMfHuXhIrfoIlIvSCSBFHRpuXIRpy+XJRqJfVpRW11qaIQOHus3lM4zP
         htRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773095525; x=1773700325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBkcZ4vNzPnscp2wv/tDrm8if6LphvMnNawG/F/pvx8=;
        b=AaQlq8JFX7M0LXPVhj0L0eMASyQ+hSAjd1ddsIL+HRSZlWsraoMrOUX8ivTy9aWiKt
         m2Mtfdb4oq4zBn0vvVmJ9qXy007NAKgbQ5bYCAOzZk0LxgKsED4ORJD5Or4FzPhIKaQO
         rWrlTj47ZpZZJ99sOSElK1IhGMuEBEhzsbq4I4w4ma57MvpgDvPLVMoB9hSxpihloPZB
         h0pNgClNzil+kAsCwwb4NivK9jPq+S0OdlfzYuJ8+vXIj219HsLTV95WIPnYVj0II3A8
         kagdZu2f2r1lpFVOEk90cD99r1oP+FUjJhHA3r7QZrBht+mI8T+FnvxdjWx/VTMIWhFG
         qQxg==
X-Forwarded-Encrypted: i=1; AJvYcCUuaAwn5Anv6pzx69/eKhSrOsJaAlAKfx35jWHKFM5dmmgGklzcru+e4XJ6Pmcnc1x0jeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEtviLkTPTT7vNQ4DizfG01MPPfxOJyj4wtxS1pfcDsEEYGVI+
	AOeT1+g/tqAnwoMlUyGwXVHaIqJmlKhQxbu3WrBOtGLogNJntuz8/+Q1xtu9C14A5A==
X-Gm-Gg: ATEYQzyBSksfNMbwjMGbVn91/sSjTTXwGbKUl/gAiEX/qZOP1AvU42DGr+ZEGZVh0Ew
	Dj4GcnKQ+AiZ0Btdt8y1FblIt8ajDQhxQAein6zCiR1DmIrnWRdfzSZNDwcThuVKJwUEmSwRbdP
	i3YpIDOiEWJQNx9hNcL5uuAiDybO4v9inqaaqlTeUFZNmbUbLs+ILROPtEe+KMrGx7kTZEWi5L8
	uSSIxoGwDxeuGovlHuyHMBoInYR4hM7Mm7xG4+OCDt7lXc8+UMSvkR5LB5QwgxGmLFUzr7d+M84
	sv5jfZjXBuOv10T3W3Q1fYJGVWsudt7yD9X9F9RRXNkoCJkTqk/c0XulS3jaT3yeZOF6mzdGhki
	APGsdbSBMqyv9bYgxmRswc3ImsGvwBWzGFe7QCMtLcG2v3JtBMEXVhXEq0zjhnhSI3zuoVeCA99
	+IPU71lmCSs8LKfuqe4OugkzdTdwRtnqtYXaqRX1OiR5I6h/bt6kB9JnXiNvYuNsFQ/9F4Jokli
	E3Njg==
X-Received: by 2002:a17:903:46c7:b0:2a7:5652:50b2 with SMTP id d9443c01a7336-2aea456730emr562725ad.9.1773095524481;
        Mon, 09 Mar 2026 15:32:04 -0700 (PDT)
Received: from google.com (197.23.125.34.bc.googleusercontent.com. [34.125.23.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4867e54sm11494132b3a.35.2026.03.09.15.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 15:32:02 -0700 (PDT)
Date: Mon, 9 Mar 2026 22:31:56 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	kvmarm <kvmarm@lists.cs.columbia.edu>, kvm@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH v4 09/17] perf/core: Use static_call to optimize
 perf_guest_info_callbacks
Message-ID: <20260309223156.GA73501@google.com>
References: <20211111020738.2512932-1-seanjc@google.com>
 <20211111020738.2512932-10-seanjc@google.com>
 <YfrQzoIWyv9lNljh@google.com>
 <CABCJKufg=ONNOvF8+BRXfLoTUfeiZZsdd8TnpV-GaNK_o-HuaA@mail.gmail.com>
 <202202061011.A255DE55B@keescook>
 <YgAvhG4wvnslbTqP@hirez.programming.kicks-ass.net>
 <202202061854.B5B11282@keescook>
 <aa8fNT3P54t5W53T@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8fNT3P54t5W53T@google.com>

Hi Carlos,

On Mon, Mar 09, 2026 at 07:27:49PM +0000, Carlos Llamas wrote:
> On Sun, Feb 06, 2022 at 06:55:56PM -0800, Kees Cook wrote:
> > On Sun, Feb 06, 2022 at 09:28:52PM +0100, Peter Zijlstra wrote:
> > > On Sun, Feb 06, 2022 at 10:45:15AM -0800, Kees Cook wrote:
> > > 
> > > > I'm digging through the macros to sort this out, but IIUC, an example of
> > > > the problem is:
> > > > 
> > > 
> > > > so the caller is expecting "unsigned int (*)(void)" but the prototype
> > > > of __static_call_return0 is "long (*)(void)":
> > > > 
> > > > long __static_call_return0(void);
> > > > 
> > > > Could we simply declare a type-matched ret0 trampoline too?
> > > 
> > > That'll work for this case, but the next case the function will have
> > > arguments we'll need even more nonsense...
> > 
> > Shouldn't the typeof() work there too, though? I.e. as long as the
> > return value can hold a "0", it'd work.
> 
> I gave this a shot but then hit a wall with the arguments indeed:
> 
> typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_entry *entries,
> 					   unsigned int cnt);
> [...]
> DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
> 
> I can generate a stub with the matching return type using typeof() but
> the arguments have to be fixed e.g. to (void):
> 
> #define DEFINE_STATIC_CALL_RET0(name, _func)				\
> 	static inline typeof(((typeof(_func)*)0)())			\
> 		__static_call_ret0_##name(void) { return 0; }		\
> 	__DEFINE_STATIC_CALL(name, _func, __static_call_ret0_##name)
> 
> I believe this would work for most perf callbacks cases except the one
> above because the arguments would generate a different hash for CFI.

If you need a stub with a matching CFI type for an arbitrary function,
perhaps you can do something like this (arm64, untested):

  #define DEFINE_TYPED_STUB_RET0(name, reffunc)			\
	typeof(reffunc) name;					\
	__ADDRESSABLE(name);					\
	asm(							\
	"	" __ALIGN_STR "				\n"	\
	"	.4byte	__kcfi_typeid_" #name "		\n"	\
	#name ":					\n"	\
	"	bti c					\n"	\
	"	mov x0, xzr				\n"	\
	"	ret					"	\
	)

For the !CONFIG_CFI case, or architectures that implement static calls,
you can probably just point the stub to __static_call_return0:

  #define DEFINE_TYPED_STUB_RET0(name, reffunc) \
	typeof(reffunc) name __asm__("__static_call_return0")

Sami
