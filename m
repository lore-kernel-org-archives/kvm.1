Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6568E1DF73C
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080148; cv=none; b=T9rAmNpgiY46J9uQh6bZYjgGjlkGLJBRHxpixu6UTDbp/fl1wLEBigRqvwcc2OKWGuTGRomFb7cNCPWf+vagtAoOoc6PNNzNlitVGPgfTCME98SIRdbkvbAw2c3KdzyyI9Lt03WJnyt8gh1OfjwCFoTPxANBWC/Sbv+5QWC+lUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080148; c=relaxed/simple;
	bh=xpfeRfEwx4Ob+LRv+rxTQXQuKagjWOR5soH19Grw50E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0/ly8fzHipz88iovkKqwNNJ1bJg+oOJLSIhkE1qKNYmQIKjbx9wI2TPprF62fBKXSr6/bCVcU8pqHXcC3ximz5gmpAF4YEt6sJtJRdrbJSYJ/KlcQS8Lk/qcvwx4NTcRssfBHyOe4azLmdlSBUI4Ujv/82N6OjL5z6syE+4O5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYWUMnru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYWUMnru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134D1C4CEF7
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 21:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775080148;
	bh=xpfeRfEwx4Ob+LRv+rxTQXQuKagjWOR5soH19Grw50E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aYWUMnrujHEbIyJIvplE4bQcY/8+4yLzkrbOH+zOIVwK1G6QVst7EnEcnomrxjqGz
	 dyXGI3L7Miucrs00PNchjwyjtGdiexBhEGF0yhTWXHG7RqRNKbjtbUIKLIvBTEjwCW
	 nRnKyFOR4Yv6tjbaVQlkR92AsCLKdwrBgs1O79cdkQXZM9RanBKCmoL6hd60t+tiyw
	 4XJ3s5B0PfZRBoFt4rJvpdAOpAv2DW8RXxVIAn2bW3xPANqkaoGDuglBRKMYhrMdyA
	 bDM9bXpJomlhzw6o+bu8fX4VTZ9++8KmpEwg+m5AIzSD5EQlYyJf9dKVP3naPNmbpZ
	 B3qJ50yX5YiFw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9b1df1a6b3so26875566b.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 14:49:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdOnH9RkfF/APNohM/8zpK1VxLIFwW8v+QS8rsMgE/I7ptx0QeFDywZtgoWQt4Fej/Kdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfMLY2ia/KKzdLoXOkheJniD7WahRswyR6W0qeKS8cWb1fGOp
	vvmpIuFjFskYvrzmFNlCtOJz1cpqlt4FfcbLQjTn8uBv1zGirUaS5pFjKHMXmUL68G7a1k9WZZF
	+BawfGYwKe6IWmKhRSWF0Xd+B7IVm4D8=
X-Received: by 2002:a17:906:6296:b0:b98:7e30:8129 with SMTP id
 a640c23a62f3a-b9c13b17feamr385114766b.32.1775080146925; Wed, 01 Apr 2026
 14:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB29vr=U=SaQR9m_O_cZwEKAG2LTnbYGjE+uT0snUT7Jco_3bQ@mail.gmail.com>
 <ac1OXbMbAY4snEPg@google.com>
In-Reply-To: <ac1OXbMbAY4snEPg@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 1 Apr 2026 14:48:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zODkS5sViRaED9DS5UhuP2+wvUzCmF2L7MJuG0RUyEuRQ@mail.gmail.com>
X-Gm-Features: AQROBzDKnDKy3gn0pTOj-jM0BOZf9dJjxkiFcVhRMDXu0irBJUoilEaVnxen5aY
Message-ID: <CAO9r8zODkS5sViRaED9DS5UhuP2+wvUzCmF2L7MJuG0RUyEuRQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Snapshot vmcb12 save.rip to prevent TOCTOU race
To: Sean Christopherson <seanjc@google.com>
Cc: =?UTF-8?B?7ZmN6ri464+Z?= <jeon1691951@gmail.com>, kvm@vger.kernel.org, 
	pbonzini@redhat.com, gregkh@linuxfoundation.org, yosryahmed@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Add rip, rsp, and rax to struct vmcb_save_area_cached, snapshot them
> > in __nested_copy_vmcb_save_to_cache(), and replace all direct reads
> > of vmcb12->save.{rip,rsp,rax} with reads from the cached copy. This
> > ensures all consumers within a single nested VMRUN see consistent
> > register values.
>
> What is actually visibliy problematic?
>
> Assuming the worst case scenario is a WARN, then I'm very strongly inclined to
> either (a) not apply this patch at all and instead wait for Yosry's full series,
> or (b) have Yosry slot in the most minimal fix (e.g. for just RIP) in a stable@
> friendly location in his series.
>
> There are many, many nSVM issues that need to be fixed, many of which are functional
> problems for well-behaved setups.  For me, those are by far the priority.  I also
> want to fix the a guest-triggerable WARN_ON_ONCE(), but it's not urgent, and not
> something I want to spend a lot of effort on with respect to providing an LTS-friendly
> commit (though if we can get one cheaply, that'd be great).

I agree with Sean here, it's probably not worth fixing in LTS kernels.
The series has been in kvm-x86/next for a while and I don't think any
of us want to change that, it took a bit of work to get all the nSVM
patches there in good shape to begin with (and there's more pending
patches that depend on current kvm-x86/next).

That being said, I personally do not object to LTS-specific patches
(e.g. like the one attached), if Sean and Paolo think it's worth it. I
don't really have time to do that, but I can help with reviews
(although I will be OOO for the next 2 weeks). As Paolo said, be
careful that some older LTS trees do not even have the cached save
area, so they are broken in a much bigger way.
