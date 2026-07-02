Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF230C60F
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962843; cv=none; b=tPaGPbwQSkxy2Bb54s/ZlmA6mJQBjaO4jNVhW6Hz/smZmbz0OQwgEUVD+XPgpNytO4aATr1XwdlUDIfV5pIzy83tW04JBxm0swZl68sxGH/YlYjF3speRAhx8K/dCcC2oLmC8zNFa8Uau5jmh+k1OJwalC+it0agghiH5WKO+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962843; c=relaxed/simple;
	bh=qL32w5wHXdzRYkyglgzXTze/5FJ6YMKFbPheQYhccpM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtlPtnvbzkDqaP0N3HTOh+wSPnSRfZ3RuxM7Zd9P8Ys0cyIx354jIUD46FuZy8vA9ATDy1E3+VYqKxsAYNxfd7zM4rJNGLy3FEbk94CkxJ4U6MCBeODIsdGhdQgnC1QIRZxutvdkCXXzUUOZ1gURsCLOE7ho+nGgyP/RQ1Wq/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1782962827-1eb14e680f11e190001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id wSzJLaDAPBXuEqqR; Thu, 02 Jul 2026 11:27:07 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from ewan-server (ewan-server [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTPc61de01aefa5fd59733e2cf6bafb509c
	Thu, 02 Jul 2026 11:27:05 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.24.2
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
Date: Thu, 2 Jul 2026 11:27:03 +0800
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
	tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com,
	cobechen@zhaoxin.com, tonywwang@zhaoxin.com, ewanhai@zhaoxin.com
Subject: Re: [PATCH v3 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX
 cryptographic features
Message-ID: <20260702032703.x6zd4aly7xvy7eye@ewan-server>
X-ASG-Orig-Subj: Re: [PATCH v3 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX
 cryptographic features
References: <20260610023512.3690734-1-ewanhai-oc@zhaoxin.com>
 <20260701024521.kffehv7bxcjc5f3y@ewan-server>
 <akUfrLPAAUuD8zRZ@google.com>
 <20260702014926.GHakXDpsIK5srVj0Mk@fat_crate.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702014926.GHakXDpsIK5srVj0Mk@fat_crate.local>
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1782962827
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1237
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.01
X-Barracuda-Spam-Status: No, SCORE=-2.01 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=FROM_EXCESS_BASE64
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.160890
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 FROM_EXCESS_BASE64     From: base64 encoded unnecessarily

On Wed, Jul 01, 2026 at 06:49:26PM -0700, Borislav Petkov wrote:
> On Wed, Jul 01, 2026 at 07:09:48AM -0700, Sean Christopherson wrote:
> > On Wed, Jul 01, 2026, Ewan Hai-oc wrote:
> > > Gentle ping. Any further comments on this series?
> > 
> > LGTM, I'm just waiting for -rc2 to start applying anything for 7.3.  The only
> > question is if Boris is ok exposing all of these via /proc/cpuinfo.
> 
> My canned answer always is: Documentation/arch/x86/cpuinfo.rst and I'd suggest
> to the Zhaoxin people to think twice before exposing things in /proc/cpuinfo
> and burdening themselves with maintaining this forever.

Fair point. We've thought about it and are fine with the commitment. The existing
word-5 entries already expose their flags, and keeping the new ones consistent
seems like less hassle than making them a special case.
 
> But I don't know of anyone who has that hardware and so testing on it is a bit
> of a problem and so that leaf is a bit of a don't-care. I'd say.
> 
> Btw, Sashiko rightfully mentions:
> 
> https://lore.kernel.org/r/20260610024350.F13471F00893@smtp.kernel.org
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
