Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750A6340A6B
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481093; cv=none; b=tar2OymAYL2sMMmI7wAKnJHpAAd5EW+radRNUDNI6Q7oN4cshlTUjFjrjYqUpxp4yY/PAGlRqXTqoO0yoej3Rp5czFY6CHdBDe3OxaG/HJFi5kNo3KVHAe6QCuA+jVy1ttO4349nf+twLSN0tY7CWk0Fp1eCUC7yb0ZhdfNe87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481093; c=relaxed/simple;
	bh=0gJ11eK6vyMd1f9poJ8vcFJX9j9y0Pob+2gbkGLs9ew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XTR21jZKcoFUxiRc2hGRrKpPj8G0PhpMBsRSiarkcbWTMvR6aDxtqh8RfTHXUd78iVgBiw+7wx83FzCJjNZBK56AR4JOBW1v5ejtJSUxFWbGGn2qtBXPOFnouwto3aaE81wWGDygxuwRJMFg94vOzVZr9UpdHAoNdFnq16wASP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFAdIlR0; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFAdIlR0"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd753a52bbso24125965ad.0
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789481091; x=1790085891; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANfnbIvY5HHUWypRItLWP/OqJoXyH8gPZpwc115le6o=;
        b=NFAdIlR0pH7f6RKqyNQtJVW44jLxxeFbp8GfJbuW1Ruly5eK/hRhx+TB+XTWsPJILA
         ShqIlDV1YZVBV7MjYoGT/M6twQ7z8h0vzdZZT0sffVOwFqudYM05YNhwFFmpUlyk75zh
         ULzz54TfZ//Z+Mbqou5HGvOo3yuV6zs+AEwO6iXkMeCrCLf9Puo42qqHhBWdWtdmbx6S
         6hxQKNVeEa/uof48yivUXcJnkTwWw5VtOekvlshFmRaEweVPpZOdwbuStkhj0mFBc+b+
         azfH9gPMcyramvQAMt5fFlK3R3QfVDRZAQ+8gm8lJaF6mZBtb0NFgxm9ZGNSgPaqEZZo
         q63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481091; x=1790085891;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANfnbIvY5HHUWypRItLWP/OqJoXyH8gPZpwc115le6o=;
        b=x7E2Xe22VVtnx/1YHuXj/EIcugTZQgW8eFqdoVP3J974Cssxn1vKbBqyRY6XC6bW3p
         CaF6s7YA6RfgJjYPguq7qyLca4s4Yeoadi6GR59I3WX5Rsl/P7x1HNx3aSIMM3QTLxPf
         LlwI/SIq3oDaPLwivpVP0bwR1oioOdn2zP1j9ckF06V9Qxn9tcr4gCZksET9h/6BiUG6
         rN3UZl+TfU3e9xHUXAeuIBqnrKkNowpinQdfdwpevua/PQAjw5SZMFCwoxbt+Wbs3AFe
         ew7+GWPj9T398XGi2A5YMckuETSY8Eo3ZZobiHTyZMpSz7ygkOmTk4WKsIJtSPQDd1Rt
         VbtA==
X-Forwarded-Encrypted: i=1; AKwUvByA+J+n0Da+uESYbRsKxxjhnTpBAtXbfg75HHS0gen/yuXw037gb/qUnd4GByXK6H/u4Gg=@vger.kernel.org
X-Gm-Message-State: AFuF++kTZ/B3nmMgP9ouoE8opG+GPImZtTj5NgDo4VhPP/Za7CZz8n0Y
	bi0rwcKpgB/Dv6iE9AepA7kAjBGGTN96V6d5VZ01dtHa0xy9ofQo/8zlnBMLEhxmjM7C2507Cii
	z3pXaLQ==
X-Received: from plq6.prod.google.com ([2002:a17:903:2f86:b0:2db:7a1f:5d7e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d488:b0:2d7:f0:896b
 with SMTP id d9443c01a7336-2dd6c6c0d27mr131092555ad.13.1789481090362; Tue, 15
 Sep 2026 07:04:50 -0700 (PDT)
Date: Tue, 15 Sep 2026 07:04:49 -0700
In-Reply-To: <c5076e4a-0335-4ed1-8049-a3ddf486ea03@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-5-sohil.mehta@intel.com> <e6220b0e-0f5c-435f-823e-318b527eee8a@intel.com>
 <c5076e4a-0335-4ed1-8049-a3ddf486ea03@intel.com>
Message-ID: <aqlQgQgnLDf2CHqx@google.com>
Subject: Re: [PATCH v4 4/7] KVM: VMX: Implement LASS violation check
From: Sean Christopherson <seanjc@google.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Kai Huang <kai.huang@intel.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Chao Gao <chao.gao@intel.com>, 
	Yosry Ahmed <yosry@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Matlack <dmatlack@google.com>, Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, 
	Kishen Maloor <kishen.maloor@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 14, 2026, Sohil Mehta wrote:
> > Yes, this could be a matter of taste as taking and going to maintain the 
> > code. But as a reader looking at this, the logic was not that easy to 
> > capture at a high level.
> >
> 
> At first look, I found it a bit hard to follow as well. But instead of
> splitting out the logic into 4 static functions (which have limited
> value to the rest of the file), how about we add a high level comment on
> top of the function?

This is a great idea!
 
> I'll let Sean comment whether he prefers to change anything here or
> leave it as-is.
> 
> Note, some function names in the proposed diff could be misleading. For
> example, is_user_mode() checks the IMPLICIT flag in addition to the CPL
> which feels odd. And, is_lass_enforced() seems like a generic LASS check
> but in reality it only covers the supervisor data rule.

Yeah, this is my thinking as well.  In most cases, I would agree that we should
make the high-level concept as easy to follow as possible.  But helpers like
these, and even is_user_address() vs. is_supervisor_address(), highlight why I
think we should keep the more open-coded version in this particular case.  IMO,
the control flow isn't hard to follow because of poor coding/design, it's hard
to follow because the actual behavior of the CPU is complex and subtle.

So for me, this is more of a feature, not a bug.  I.e. I *want* to force readers
to slow down a bit, because while the basic gist is indeed very straightforward,
I think the resulting code is actively misleading if we bury the complexity and
subtlety in helpers.

That said, I love Sohil's idea of adding a function comment.  Someting along the
lines of "The basic flow is this: <example>, but the actual behavior is far more
subtle due to many exceptions and edge cases".
