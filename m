Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EFE470EA2
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859276; cv=none; b=Cn82oF4FpLnudAGR5Z9i+rLCjfo3oUJmMAeUXF6z1u8DuF52i0z/xxxr5W2AXUPz1akCdwrlybFxXr6vQORvekDuxWiKY1dGjPjVj6dfpriI3N12HFttz9rDjSJLw3oiEi3MygbMQ1Z7q6gkV2dUvsfb0Ptr7Ff6gtFxlc3mgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859276; c=relaxed/simple;
	bh=CXeLDMtwKsuAiRqbdkAJJBlPnxsxpXz1LOI6gpzsWug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RowXmmjzXKQPwKeptZmqC2wgCAqVuEJQA5hWNRmJKQWFRyhEyfeVJ+qn/xvEE5UdJvoSjO5cLlvU7QaRYTy/xklmgDE5Y64HhEfvaU31sU02DfFVVUEB7B+kcNcN+jsm/+dlpeITB3E5q4DX4DzvWPlEMWQWpESCbwwBrl81ZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wdD50d8L; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wdD50d8L"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-854f274dd69so558737b3a.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 12:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787859274; x=1788464074; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dg12XoIFyQkc7HYpiPyGSu+F6pcgqgzKa/+pfUliURY=;
        b=wdD50d8L4JT+BhB+AquUE3INFIdI1x7eLia7hnubn0iVi+6WAGNH3rBIdS6aikf0z4
         Z/Zr9OI6P0MdGlBksotUE43udsIfc9UtXILQvKuNChpSfs0f2wjXNpylRf7rsm84X7yu
         m8R6z/5ae+gJ8XpF/u7xYpzpf1CtnADkROSS0Xywzpr447uY2yBLrE+nWdAamFY+d9+P
         vUECMUhZ1yD7QDrYTC1MHAQGGy7HYKEB3sksBWKENlMGnpk4C6fMxJz0JDOov4uNL38v
         uwrx1WAP0+WjjQfjmKi29lPvakiloyoxaIgeMKvyAMIKpTT2LAZdrhXmL9tIBnnVVB70
         DGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787859274; x=1788464074;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dg12XoIFyQkc7HYpiPyGSu+F6pcgqgzKa/+pfUliURY=;
        b=L+k/CPwc2DiVrRCoUE21O6N+SAuEtF2Ra1z//Y3nXtBrxUl84L9dbc0Rr0Ic244R3A
         WcZMS5Ww/K9v/cw1qOPBvLDGqm597SDEBFNk4ew9jtuXuRcQfbRulynrr6XGHpWeEYoX
         CM4cmBjUgJ3Yzl4WT8R3iUwwJtr5qtwOyEvE9TsWTCpFWJFNTv0JXtV3fntVD9+VMYGc
         DSlrwfM3wv/CLLaj+7NfgjvoB9dxLozxNROn+0bra1YjAMZTM2hH2vYxGq/fzwJ6qY4z
         6EYWw3WH3if2lzJdL4p7oXWjqsDGGobyrm9V+Drc6yLwjCNkg2+AV7ulNLZVdUXAXQ0z
         jaEw==
X-Forwarded-Encrypted: i=1; AHgh+RqRMgnNiydKLPwRJFjya1gC/aX8SYm09lAOYhoC+BHJj8DIx+o7irVPQLUaRmLc04n1Gh4=@vger.kernel.org
X-Gm-Message-State: AFuF++nD7PDAg3e0qZT6veKy+VyIOzf8pJqtBY6U0WgbiOFLhgoDt/IE
	WBYI+ol0rJNa9sS1FYXfG/HjYZ+JLF5nFMvEyfPgAzmovlnGI/k0GeFvOFt6uiOY7DGk+vBA28A
	DWwTaMg==
X-Received: from pfbf10.prod.google.com ([2002:a05:6a00:ad8a:b0:84b:77e6:b15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:194a:b0:847:9267:2104
 with SMTP id d2e1a72fcca58-85629a24448mr2685408b3a.12.1787859274040; Thu, 27
 Aug 2026 12:34:34 -0700 (PDT)
Date: Thu, 27 Aug 2026 12:34:33 -0700
In-Reply-To: <56ad5526-76c9-4cca-85bc-242a09a98936@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826171246.777729-1-seanjc@google.com> <20260826171246.777729-2-seanjc@google.com>
 <56ad5526-76c9-4cca-85bc-242a09a98936@intel.com>
Message-ID: <apCRSQXeaLntqDdD@google.com>
Subject: Re: [PATCH v2 1/8] KVM: VMX: Move the shared "IRQs off" exit
 handler(s) to common code
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 27, 2026, Xiaoyao Li wrote:
> On 8/27/2026 1:12 AM, Sean Christopherson wrote:
> > Move vmx_handle_exit_irqoff() and its helpers to common.h / main.c to
> > capture that it's a common handler and
> 
> > to allow guarding against incorrectly using to_vmx().
> 
> For this purpose, it seems better to put patch 3 as the first patch?

Huh, yes.  I have no idea why I didn't do that in the first place.
