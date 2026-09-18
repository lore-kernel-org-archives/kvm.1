Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CF3264C1
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729980; cv=pass; b=PemW223ISJkeuzJKKfYFzgH+BvyBfDt4kPy45rXptQwg5avMRpkQQs81TNC1/W0i1O2mamsTicXiQxEUHvs4uNJmjpw1rtHmcZkFQYeJHitYxwniWI4MxQaaJxPE/zxRIQTq0ZuKXIOXP1xytnPA0nixDrZWdFCADxwdxpeh6wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729980; c=relaxed/simple;
	bh=TXdiK+zXX3XOHC+zbrRgQmzWKL9JH67eZAMPC/L+Ipo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmoRQ8XzeZQmntNPOTL7aaAEKvqRe3KC2Th8L7i+s1LuKIdJWrSs3F+dzQR0T+CIRsIjul+yulVsQsRh2HGcxYINQnZUscIF/PEErTt85jtEMudvNUdJid8+1OHzb+25cLppOyx2G/p0UlGtqeviLp7Uc98op9AUzp9aGQSwjyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPH5DHwy; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPH5DHwy"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6aa13d8d9d0so6454a12.0
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789729977; cv=none;
        d=google.com; s=arc-20260327;
        b=Sa/Lrj/akzqwSfzUycK9y0B3oZlLU0fsPD+VhYucOzszWlkabgrortn/vIVdYpYQpd
         egBkQMIyr7//4DQ/OVjQ7Gk7IW4LvWBWar6mg7cicpeuyvmy4cig2e+RLk2PGMvfOedN
         mg9KaxEXK5cFUGTCDGsYZoPC/KSimQYEbfYVXXEeXrwOej/dPv6HDUb8SP97nUq+/9Rr
         y5oV1/7/rVwytgTTq9TcSw9Rc49jXR+fYKdfWbzedEFOCMCMTzqEnLVDihE86ZXAi9eD
         Dm9MxDZqt1YM4kJ55Ui/7hmCzrePDCHwzW5MBF8SAlzAaR8ybA/Xs2ASs0ZIPcMkAv3L
         YBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IsRHyK7/8v6RoJOuWPNWhyP8I7Up7HtkzKNhXSeAMl8=;
        fh=yVATVMzQDsoWN0k/wxQOPSKsp8wnVX9gs/ZJu9GmU1s=;
        b=GZtO3dLolJfq1oTV6psdnytS4pKAm18aJFCdHCjZdU5duQfqA0HRkpRuBgav+sr5Ld
         uIJBAVkOQBVE1DBs25AwpRK5skcJbRU9gNJgwdHWG+NBnEVDnfJkyJr0147tK9MdLfcH
         h8bh9U0VUbR37rog20svKV9+x6eH8vP6uAAs8b6Zkyriq0Yb2114SIq4stnXWxknMTOk
         PDdZDDJ8fMHsFTz9oNNLncAjex/yZZAfg5JMKtCgODBOhTtk1g14JaCRo4yi0vKqxJXw
         1I1UWRrsGtK3TYiGh405p0GGQ12mQwngN0ixFXRfsJ72Le7aWiSN/VkdyjvXzoeUHYNg
         tfQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789729977; x=1790334777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IsRHyK7/8v6RoJOuWPNWhyP8I7Up7HtkzKNhXSeAMl8=;
        b=hPH5DHwyZcX6rRCO/qljV7CtstYS4wkd8hQQSPvSO8ahuIG83enstvM2pB2/DOHywV
         BplLMYOGxu0EwmhkJ3oLKjb9fNU1fVQL8We2Wfxqlp44BLJlLCvegAqUD3B8sQbwbgm3
         d4kIbyjjepbF4Sf8sIrcJoKYHnIN+XzT34rrs+4YhWOYgYE8LJFqS004gO/8PWxxL9DF
         Jjl7Ew0OK6f56KjAkx5jVqylN7lXMoNoYqjrDzIeiC0xdisynQ6NHA9yzyVLUFqOBVNq
         cJFzrTkYEG6JfLIxM8Qh7HJp6TUsqiLjBHAyJNZzMbDrX4H6tL4V4d384NzbVe7tS1SP
         0Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789729977; x=1790334777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IsRHyK7/8v6RoJOuWPNWhyP8I7Up7HtkzKNhXSeAMl8=;
        b=PuV3o5Vj1LXGyo5x0mQ+2vxuRvwypUDPaZ+YApnje74lZW+/nttl3HHOqKB+BZpKwT
         v4Ku/7BZZnsB3N8LXy0M4jzvF/2ca+eDZHldr5g+rcZt/qvX6vagtZ+qD/nKwvzLsHqF
         VV5BIo+HhIon9Rj5i/HEpTBnfCpmtq3cQuY5m1bwhfveqVwd9LMZLP9ruQ++WW3qpwP7
         eaJBIQwoP0mqa1+H2Tw3+8W0yte0ng3KuSsBy6GSs9sW9kjLsxxdTJFb5RQuw1cxe/Bw
         Be0ES1M3WhKgKOEW5OlOBeLlNVfvij3ZlG1tk21aFHGrk9DM0tGCNy8YlLmWEpgTM8nZ
         278g==
X-Forwarded-Encrypted: i=1; AKwUvBw1ZttqcTpC1qzpDkBKtjsD9jX+4lHD+28pLVhnk3E/uzpp1X7ClVsbUSe45rQn1ukZa1M=@vger.kernel.org
X-Gm-Message-State: AFuF++kWhwS5XGGcrR4tnEFkzbm4EqtRCLvrc8q6Hi9rPE0mV/dF/ZXX
	BKsYpHypyuRRQcrmhmoC8yShFezuS09YQMzVF14PS69TH3+JANgOeZye8TKu6P/Hh8yPQPXboZB
	z9G4Vjk1hyNXd32H7AiYV2OdAH/r1ZWiDjenTGQz8
X-Gm-Gg: AYBFou0cfjwVSIRxvclxxJJ8gWRlkMtZ2zSiGC210LZKDAoT15j1CZyf2naRMHjV5tc
	GluIQkostsU1m6n/MuxqTbbpP6d2BCbEd+jhccSLPPyaRcVzhrR34sVz7NQucdmkZ4RSG2Y1DgS
	4wsrNcceFN3EzetmsH3n6/qTcyljJv1RiXOiciqyUAqXv82aKdDjUgwx5UwNCPdbeCVlqPsqgAi
	DHL/JIg1JbMCN+MRjyOQvGOaREnJdIW9w4PMeDkwUbD/M/bj3NBP1W/Vq7W5rXj1tLGOSpWYKoI
	sljVEmTIU0FqT9ZUcNsTho+K8HEwRW+iqUJ8fAAMD3sECyFWxNDmXWA=
X-Received: by 2002:a05:6402:c318:b0:6a7:ef71:28e0 with SMTP id
 4fb4d7f45d1cf-6aa4de2f154mr26742a12.0.1789729977107; Fri, 18 Sep 2026
 04:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789721173.git.zhang_wei@open-hieco.net> <1fc24efcd29e379c3784f661512cd3ebd833e463.1789721173.git.zhang_wei@open-hieco.net>
In-Reply-To: <1fc24efcd29e379c3784f661512cd3ebd833e463.1789721173.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 18 Sep 2026 04:12:44 -0700
X-Gm-Features: AcwNN1XzGDkuAKwNUHrle00CDHO2BYgnV92QAH54Tlu9yL0UYsep9hP_4pNWdHM
Message-ID: <CALMp9eR9zkPvmaiox1N9hxrCpuUmMzxPzynJyP3op=jhLZiXxw@mail.gmail.com>
Subject: Re: [PATCH v7 3/8] KVM: nSVM: Track valid hardware DecodeAssist bytes
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:56=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> VMCB02 instruction bytes are valid only for the hardware VM-Exit that
> populated them.  Track whether VMCB02 contains instruction bytes for the
> data #PF or #NPF currently being reflected to L1 so that stale bytes are
> not copied to VMCB12.
>
> Invalidate VMCB02's instruction-byte state when preparing VMCB02,
> normally in response to an emulated VMRUN.  Mark the bytes as valid only
> when the current VMCB02 exit is a data #PF or #NPF.  Opcode exits and
> instruction-fetch faults are excluded by inspecting the exit state.
>
> A subsequent change will use this state when propagating hardware
> DecodeAssist instruction bytes to VMCB12.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Jim Mattson <jmattson@google.com>
