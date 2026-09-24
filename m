Received: from mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C44AA1F1
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273968; cv=none; b=l0hOe798ZDR1N7AXBYyLpTUIVhdQpctP2HvB509pMA1vYIJjGd4riatdtlkXMxMPOCb0vEkJpN03mbcS+teo/3TaIPIb3fDU/rHBMG+cg0+c74ynvLo1/vl+ACTX8IDTm+oT1Yjd36v1dYzUK+Qp1n8laLQz42CnqgSrKy5PmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273968; c=relaxed/simple;
	bh=IvUR2431T4OLwHWTHJUJSLYNuzeAJuOHiFRGzJguyA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBaddg0ZQTYAQB5d1D6NIlNsM/Ly4aUn9MvKk53ixHuPGanS9+f7OnYjSWqT8yIYfSl6sjQCh2kGgXFzC14VqqPf2iKoKUFMaj84iyRmz5JCWHkss5DSA/IFb87gNIKgwwC4lfFo5fbtfGvFN/mAgoAPmfvlCDMxw4YRrl+yJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kjsKCtRX; arc=none smtp.client-ip=91.218.175.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjsKCtRX"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IvUR2431T4OLwHWTHJUJSLYNuzeAJuOHiFRGzJguyA8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790273964; v=1; x=1790878764;
 b=kjsKCtRXIqG4QH2wQZyEg+X8YJPcg9dCxfnIUJWKoL9rsxzPjHSaS08FE+DrlB39h5bS15Sc
 hvtqmsaXbWLsVjQyqyhgSg+a7l4wrew8htzHcpxR1PmDTc98s088Ndcl8B/RGT7YCwqPrtB0XMg
 cYs9Ek/fE5o/BKn+N9oQAeVo=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 320800cbc2104eea;
	Thu, 24 Sep 2026 18:19:24 +0000
X-Mizu-Trace-ID: 320800cbc2104eea
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso973e87.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 11:19:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy9pQBh4SpOL+nQUWZoUIOGb1RnRtB3jkOKDnZK3s4d2XVuPy1o0aGJosw94VAV/xc01sY=@vger.kernel.org
X-Gm-Message-State: AFuF++nViyDUZcIugOjo2HUz+5XQpjy14rskVmn+r3nAGVvZw0HLkL6f
	Ck2kP/iEEqVH+wzQ3WEjtqFQ6eOhm5gz/RA2w0f01y7n2u3PGagZe78OCnyBhGfRF2KrXXwLrT5
	mfrJpMewhp5xowJRUgNHEYoGmpK5OzsRT+5GoUDtI
X-Received: by 2002:a05:6512:3ca9:b0:5b8:e262:d32e with SMTP id
 2adb3069b0e04-5b8e57821dcmr16882e87.1.1790273959309; Thu, 24 Sep 2026
 11:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922071945.693714-1-fuad.tabba@linux.dev> <20260922071945.693714-2-fuad.tabba@linux.dev>
 <arVQutV75u2gGVr4@google.com>
In-Reply-To: <arVQutV75u2gGVr4@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 24 Sep 2026 19:18:43 +0100
X-Gmail-Original-Message-ID: <CA+EHjTz=n2Tnq73amL3cok0=_vn-cigesdd1r-emt=+__Xatog@mail.gmail.com>
X-Gm-Features: AclHuK8gQuMnh5G0uSWpcfUI1aukInqrdbq0WmB1N5HLh0hWNnycc7FfERA0vUQ
Message-ID: <CA+EHjTz=n2Tnq73amL3cok0=_vn-cigesdd1r-emt=+__Xatog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: selftests: Fix arm64 sysreg header dependencies
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	James Houghton <jthoughton@google.com>, Will Deacon <will@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean,

On Thu, 24 Sep 2026 17:32:58 +0100, Sean Christopherson
<seanjc@google.com> wrote:
[...]
> Definitely doesn't have to be now, but at some point should we split out some of
> this arch-specific sub-Makefiles?  It's nice not having to hunt around to figure
> out which tests are supported by which arch, but the amount of arch specific goo
> we're accruing is getting unwieldy.

I think so. I'd keep the test lists where they are and move the
per-arch build logic (the ifeq ($(ARCH),...) blocks) into arch-specific
sub-Makefiles. I could send that as a follow-up once this patch lands.

Cheers,
/fuad
