Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC31DDC2B
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780127; cv=none; b=U+68Uo98TUim86byx95tUh2gDx/FfSvauLsrzvM8xpMFYOFCdtRl2Oe7VDL9vPpfhmkvXd64vWvDSDrjZ6/5vIzmHj8gomqN22SnrPAx0HxDyPX/tbvQlBaymaDoT6aGsnUzjNvdfwGp/MuWOP1nUVc07ua0ZKAQnnIuYWra920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780127; c=relaxed/simple;
	bh=cshAbN6D5LTzAQCSGrGvu9YTiIKTGytpePf2gXb3rXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CdAKNVUxhkHwaBcY85Xwhm7+lz3N0MFLIUX+hMEVmfv26QmXkdTboRzwXWy+e6VQsrCjXNscyqJ3KHpPoxlWX4G8yIs6XUCnOIZH/ANnRtNXSXQSUSyNHLXHn8x2qw9rW0YuhuwNPy26kj9B2cBVCZnZwDV+G/ywrYyGgtHwmQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKUshsct; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKUshsct"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84696ed3b24so1265247b3a.1
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 17:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782780125; x=1783384925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Gh6LWY0rzUQKB9FLNPeE5dt4Ox2OdfcTUONU/T6FNY=;
        b=lKUshsctRuAaDyX1NUON6w0x3Wg1N8qrJPd1xpf6pjlxm1fprEEjaEDnCW5cVq/Iag
         pmO90Q32c7MR2B/bRGhyccwGBOFMhcXBuqTOFSZoLydcIITTwo3g7ggVFKEIkVCG2Nvi
         K3Pxw1c/UvVwhZD+MBVISXTG7a8+1zIabaOTjx8zX8qgiGrhtpVjjKFib5K24WdHP3q6
         tCMh0FKbBEYLBI7Eghb0P0Tw7pdk2w7t1UGb4JqstdSIRRku47bQm/Dxy6o8wG1SlBAo
         KqCxu9/AfpTaKVGDt4AlOefGWkqgIqpYgGuBV2WYdgAuFc1BPIzqP2+LaqbDYJsN5Hkj
         Mq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782780125; x=1783384925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Gh6LWY0rzUQKB9FLNPeE5dt4Ox2OdfcTUONU/T6FNY=;
        b=R5e1beSo6rB2o+V5jhpCkT5fQgYaeVRqQIJfyP3Wrm6I8HIH49QiZX9EQGYugRwrG6
         qLPAzfe+AwhktyguiuXvj4ggradkamNiPOer505kz4UBVdFIQcLl2TK0oZWocmBihhS7
         1vm1NU7FpaeLCPidByAQXSRmCb1L3iEXYP+QT/3gveKAMdo9DfxUEZYAWpOFqnTVIIKC
         pbk3SHaxD7MSJZvA9Gf0yJhbLzpZXVjHrrWHYvPDvRcicLq3M9UXZ0XZTdkGUKHJw5w8
         jiof2YJw2bJGlYG1qoYj3jW88+39cPrAtn3iL/ADORkYGPdH7VkZjW4PK/eBftq4Zw28
         VGSg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZjNqLDMWxNAFzsMdXweT9M5ZIwogGx4KqjMlw4foiaWNS+AvY0ZLnRg0GT0hAo+zykAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7B1D3AkPvpm8iH+QEUsuUPK5UpUGHZ4xR3xy/4f8PwVz1YRdL
	FeZsoX+BscGtGQDrPA5ddXyFudCqKYoWXtElJLgcr5zQ1DEu+Zqw3U0yNNPnXMBYCroGK5l3f3J
	ioGr4xw==
X-Received: from pgge11.prod.google.com ([2002:a63:db0b:0:b0:c94:ebb:92dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6713:b0:3bf:b3d5:ce2d
 with SMTP id adf61e73a8af0-3bfc50b8944mr1267082637.7.1782780125319; Mon, 29
 Jun 2026 17:42:05 -0700 (PDT)
Date: Mon, 29 Jun 2026 17:42:04 -0700
In-Reply-To: <20260629100301.GA1743876@pedri>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com> <aj1tFuwZWdPGfUoG@google.com>
 <20260629100301.GA1743876@pedri>
Message-ID: <akMQ3J6fK3DUBsPH@google.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, djbw@kernel.org, 
	kas@kernel.org, rick.p.edgecombe@intel.com, yilun.xu@intel.com, 
	xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com, 
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, dave.hansen@intel.com, 
	dave.hansen@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Peter Fang wrote:
> On Thu, Jun 25, 2026 at 11:01:58AM -0700, Sean Christopherson wrote:
> > On Thu, Jun 18, 2026, Xu Yilun wrote:
> > > From: Peter Fang <peter.fang@intel.com>
> > > 
> > > Provide an in-kernel path for Quote generation when handling
> > > TDG.VP.VMCALL<GetQuote>, without requiring an exit to userspace.
> > 
> > Why?
> > 
> 
> Hi Sean,
> 
> This is mainly to avoid a round trip to userspace for the GetQuote flow.

Again, why?

> New TDX modules can now get a Quote directly via an "extension SEAMCALL"
> instead of exiting to userspace and using an SGX enclave. Exiting to
> userspace for GetQuote no longer seems worth the overhead/complexity.

I dunno, from a kernel perspective, this is more complexity, not less:

 Documentation/arch/x86/tdx.rst |  19 ++---
 Documentation/virt/kvm/api.rst |   3 +
 arch/x86/include/asm/tdx.h     |   9 +++
 arch/x86/kvm/vmx/tdx.h         |   6 ++
 arch/x86/kvm/vmx/tdx.c         | 135 ++++++++++++++++++++++++++++++++-
 virt/kvm/kvm_main.c            |   1 +
 6 files changed, 163 insertions(+), 10 deletions(-)

> The first half of the series enables extension SEAMCALLs. They implement
> simple APIs for higher-order security protocols that would otherwise need
> to be broken into smaller routines. For Quoting, this allows KVM to get
> a Quote directly through TDH.QUOTE.GET. The TDX module needs only the
> input data from TDG.VP.VMCALL<GetQuote> for that call.

Answering my own question (though probably poorly), IIUC the answer is that
DICE-based quoting is done through the TDX Module, whereas existing quoting is
done through an SGX enclave and so was routed through userspace.

If that's all there is too this, then why is KVM involved?  I.e. why doesn't the
TDX Module provide the quote directly to the guest?
