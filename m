Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CEE171CD
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545533; cv=pass; b=Ewo0eFtBHvJWwdRZeZCvATSpMqoBQLGFfPibwMtdD6Rbc9aZIzCGe5tZzWl+BZMDWRQCwxkkS5a63O1EafEtuNew35942iDRdfytDY/pKttj2RFwPeq6kuzieiWAIRM3Px/5f5OsASTG1xVebspVE5SklL2FHtKKyiPgGD4VfQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545533; c=relaxed/simple;
	bh=8OrlT45Zq+yotjfavflRP+uvMCqve8ycqy+YcFdwwtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPbVFnN9s9S9NFm19BjBUd4rny5hTYBUtEbiepfuDBi4XZQWtVdMdEjpdyUIyR6eaLH/FNABYR3J0BZQiLb8pKE0QGDv7mD5DFSHDvli2Fm0NYy4aA09LWKXoB8S1TNkmHox+QMKrIX3PsX+ixvuXJ1T6VziMlU4Kmmd2zQ4ZdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJDEOQ30; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJDEOQ30"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490bb5ad3bdso5055e9.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 10:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781545530; cv=none;
        d=google.com; s=arc-20240605;
        b=NaJfICCwjs2yXvTGLM/hUDjJFKOv3oaUH55pWM/WK9p3ZZOOg1ipAtMSZ22V02InPV
         vc1znP5Ph2h6CdB4qUl1pPSookuAw9ZP1/FmM3ND9+8xW6jXjlvgsq4DBpj06HxmdgDV
         LDyaAj7zQqGz4btd+Xr76TZKjRkj0RXlwF/kw4gv84U7gT2FDN3JWfItNIBiz59DZzv0
         z/n1Pj6FNnNTZAcOdfXqPHZcjc8Lqsywm+LEKJPFuu0DGH1w/MluALt2q0iF3UTA9jSe
         nP/6wvcReTyc3+YkxlEJDrnpUrC+Rm46bzNUEDXY5z3pbCEXAK+tJXgsTsPfWJwSj9VZ
         sTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8OrlT45Zq+yotjfavflRP+uvMCqve8ycqy+YcFdwwtA=;
        fh=v+rmHsk2lkDaxpPmWur4xJKLMhRGah8k7RAcplWzSW8=;
        b=ieeFIRJD5kQbXWfj+TSi/+Ey4CFZYuuVvg6Tz988OCQiw4fisS/tcTN/ph0VfbYD/9
         2b1ekaAMwkU6lgQe2DO33cU8t3Rli+GtCNhDGbcgO+ZYFf605MYOfFyETIZYtx7iw4dk
         9m6A2ZWn9oRrxJWVfhMyI0MpFx9BhehmLwvBG0AulJzT5+O2CFSm0YLVLJS5AiziGh1q
         iH0/ABsd3zfnQjvyjOpdNS+NX0iG2GuhMZKiJcXSDdqgghmWzk9ZpZ6HG7lPeoxmGj4Q
         N/elemBCVVnCmWCfeUxRAfUwwrb1NZgBtsFHDeQtDy6m2UEsFHvKH1uPORnGGHGSIWwj
         kfGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781545530; x=1782150330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OrlT45Zq+yotjfavflRP+uvMCqve8ycqy+YcFdwwtA=;
        b=aJDEOQ30EAeZ2sWUT+yxiae0Cbkoxgd1LR0rRPXSQe70bBsYVTkZ7Jwu0EH6SBgOPT
         z4sLu2y9YcJ7t8FJPwC8ax7U24ZC2l6eBwjcyGyNMpCY9+aJPK4aa2iwyDReL7EcV/df
         izBFWvAIfCP9IDRIiNMpB/Tz+7AGhAR7cNU+sERcrZoGTkhymCDdaLacGRn40MfuhW5Y
         onxFV/Yg6euEob5sk4OX53CNdm4Ora14Q4jCxS3I6nPZeiwkNwin6QbtxwqPC1uMsgXY
         uHHouanmecUrCaSWZ5X833yXPveHEyVmVALGYQnMIL0yTjnewaRatxofgFEiG1QtwS1t
         8t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545530; x=1782150330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8OrlT45Zq+yotjfavflRP+uvMCqve8ycqy+YcFdwwtA=;
        b=gZEsaOjLMLUFpgOK2oA37CVnVpX/fjmtd0P733Yp0S+ABNhXDNnN+07wCl6N7c0MML
         QrHbIiY2KnIdLidCLFl539UrPo56B1kD0HYVTKa1kOtyt2sh/C6YOyEPszFqdmIqPeln
         L9ImNaZlWU3GYDZMql0WjoWfRbqY+zjtYzgdG4lKy0eWazBdCNAHyq3yD1Tai4uZ5wkq
         oUpcmtuu3o6xKU5HJU0Meagez7M18ZQPzo6Hz0lBv3KlaR39ig/nDwVw/oYLFLfJN6/q
         O8E9YmIYOxdUGl44RdOLJXcTeBSKmymmz1ClcK5BudD/fY3FIEaodVKcbgj/L1roFZE1
         aDag==
X-Forwarded-Encrypted: i=1; AFNElJ+Vy+4+5+yxarjJx/VBNdiXP1GeYQx9aIWTYegQm041oWo0QbuHTS8+J8NC/jInQDW/LME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVMmGciibcHcvqptglJKQmPtw9bOMZIEsF0ZU97suGMdphrSY
	0miwSH7FjZKKIrc3bLy1xmepyjEwUnDJvrnh1QwaLsKhiQLbIlslxCvRxJPmtJZ53/lsNvO7tJE
	KmIxTHTk9rgvIuVhhE0rliACMUhuaHosuGM0kYoYNiJ+KhFpWhjXf+yVL
X-Gm-Gg: Acq92OEkILBzE69c0IyWv4Hxj8o0b/wPBtTlq+c6Wn9ewFhsxatGLjzLKwKTf/IWl7p
	Q7BVerY551IAIWSBzjAnCxhY6a/1E2fcInGRN8Ql0fnBhHE0F3IBD0NBeeXfhMuqLyVCfNUtBjc
	lqcp3f2K01oPC1CYRa35bzCADjXbhqL3pze7IiFsEX2FsB/rrzU1L0um4N3agfQIiKV6Mw2yy3O
	iWoHAE/fi9yDT3CM/KEzcPgESsAXV1mSM17P6VJeuHOcNUPlbH+WZOsOxx77238SNyrlw58GOnX
	dQ9b18HLixY/besmFQ==
X-Received: by 2002:a05:6402:197:b0:671:dad9:8caf with SMTP id
 4fb4d7f45d1cf-6950865fa24mr4492a12.5.1781545218311; Mon, 15 Jun 2026 10:40:18
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-9-seanjc@google.com>
In-Reply-To: <20260612230113.684301-9-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 15 Jun 2026 10:40:05 -0700
X-Gm-Features: AVVi8Cdebjy8BWBt9---rQ3did9ujb7a4kWKsWeBAyd-g0JXbDcYVttqvB3Pwz0
Message-ID: <CALMp9eQtWnE6VtGxObofogOZ8xke+zsW1sNXT36W6FTD7+p8yg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] KVM: x86: Read CR4.DE in emulator if and only if
 accessing DR4 or DR5
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:04=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Micro-optimize emulation of MOV DR instructions by checking CR4.DE if and
> only if DR4 or DR5 is being accessed.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
