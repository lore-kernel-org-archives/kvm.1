Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5719286425
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554237; cv=pass; b=shmijd8CAGlrNfJ17nsG7orPstghsvR6cKaH2GGVXO4VR15VPguEzq/RyXoyaUo3kjasB56ZmQTadgmh7DD9CaoWgtNcvXDzhFsmKzdcNeIOSrc5FUGKS8rD8KKFhyRU7E974i9biABLA9yIM26Xj89pZoidRtoX1G5xgcUN6LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554237; c=relaxed/simple;
	bh=fyn8UE6P6du6IrW1SfSmKy7QHcHo1Gbox1Qxx3NbE50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYENPUmhO1CpHKqrnpQR8444LGnCl4kLMvpp0WoIJlP771u6wVq4bmWa9IJ85VK+l6ken0W8usx8mT5uqp8f/ZEL869l06vGLmQLmp/Ed0OUke99vXz0kUSUyCdQePmbXPbgGKyMNkT2dL7pnrTXcSL99N/3NVHzWZyQRxqmmkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHTr6n4p; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHTr6n4p"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so4109a12.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 23:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780554233; cv=none;
        d=google.com; s=arc-20240605;
        b=DZzx+g2Z/vkj/5t941YdA5pAzencvAY2SUckD1qB1ZIsXB9bjMvGIra8hV6A9jChjr
         WKEW0A4QKPz3pw7mL/Kr6KFPPH52EUO4ydOE6BtaZvp37PKlqgWNyxtHEjLct2zKLxJk
         uJgWxaOBGhyTsItuh1APtS58h7MDrKTUrm9SErzBrBzHeO9WrohJbw4QiI7lmu2257KO
         UIHE6JbR3DhEfjjBZotkVbjx7CVoruQ0qZFM4OndTCjXpHq1IPHJbzXkM5ietN0b3UQy
         8aP3n3A194Pv5876AAdRWF2cgbG9XiVJABIoT+OsVra65ME8um/g4IAfeUT2sdR/2Lxf
         L90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ATmrybH7o+jqldU/+IaX8GCc7NIeB6X5yfOR7H2kJRQ=;
        fh=OZbrVktd23qVBrLgLSKpCl06rHM6+0bFfv7TQsDbueY=;
        b=J6oqazd8wgMnoqe6hWjjmMS7zZoHRJjnrBzybmRGe2gb2yp5UmcU9kjLzL7DIM6MrD
         kPSnpJkcY+XZoSXRVFc6BOOzchMVqtuJ31Shhn45/4RtUO6ZRc7fzTqX/1skj3kS46V6
         otfqLtx9CBsF/b2Ox4wiFjG9smIteWaKt+t9zxuicG7Y8tX/6pA4Mavtrm8C4Z0L7WOg
         C5XWxz0Hlvha6/pnsy+WVrTAtV9ozBy50HRCN8mQt/aI1wnbhk3ZPYHOoglmo/Sh1++k
         AUYLaC4vK3vFwVvrqVGccMZwwuRyOU0jObbGgL7mjxprCSIAwuXIedCbRHaH1kwnXkBm
         n6mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780554233; x=1781159033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATmrybH7o+jqldU/+IaX8GCc7NIeB6X5yfOR7H2kJRQ=;
        b=fHTr6n4pGML8ZWHnV1YNeweFYrTWItuDq//V8MEDvX8OIhwtOWHZ6ZRblVuM/TQRgf
         e2xcMQ1i+jPDCTfp+5hW5WVuW9L7j2M3FkZYmxa37PE3kQHecETGwrlvSdrmQWHIkdb/
         mL5zNacOv6b1Ky9tzbEuoKuna6zTbAPxgUN6n9C9m2I8YjrIYXn6pqyFpALsPqBtbdTE
         jUNxbFKtBe7VH5sVW/mFvtKpHrReL9GrsH/cZXt2kI4EC7TI9bLlhBd+jU5/mlvBqPP7
         i1Y1+I29cDKUw/KmEPV5ObOOYgsbbqUYMOy8defpMKqQ43LpNVdfVHxuebs1HellZ0la
         grqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780554233; x=1781159033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ATmrybH7o+jqldU/+IaX8GCc7NIeB6X5yfOR7H2kJRQ=;
        b=C0KwQWMG7E7WLMOxVUTKIideJrMQzQ4zs0P2wtFyzooN4dsUBRGtgl16XfRDViAtj9
         qVFaLL+HGByfwU+u0RXJ0jE3AOSCRmAj/bfiTOta0GN/oIonGIIo5d9r8KzixaI50oCF
         O2wvrvaogHkgIhBZt4tAHX9H6Q59uLjKZBLuP8/lDG57fz0FIgN4+SgjAdAf6fcB4UYI
         O/Z7UkZbyjIr6QLaGjAjPQBkmzFOvyaX/yjZeQw3/bABPqUvic8cfYkvITShjNXL7Hk0
         HJpAlY4hECzkqksgga5ztXH53sjNldum/lQgCoF/In3uT/FysNU92fYQWpvV/RtG6LAG
         icQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+20NXcssKV3r6G6XY7j8VdJnJbtDiku0Nj9vjVImxKjXxhykK5kEybYsPX5V7ct/zVOfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqUQRDdONeS1BgzlN9iKIXM9TJda7FlAhmw5wqjD7pGnO75bx
	sMvCVrKg+jIgPr4rkQ4gg5VUS2lTvWjqjvlaGfvQaLBnVh2zZJrjEBlfiwNCoCBhUpj5oRWsMh2
	PLidCO0v5qrZQ5KNOLGsxjm0x9ikxle+9dgWoj3lC
X-Gm-Gg: Acq92OFUeTeKCRC8jjsyhnwwZGC08uw5oadEvuxzLGWHPk2IGThfq7Hjiramai9v7UY
	KM7O5jj9e69hjkim+m9S1gYxs0+hOtf7a7pAE5/2QYmZ4wAXrmwUmCXo0wkK+OYvJuhLT+TkaaO
	lxKofS1brCYltl5sRL1XgFZF1BdkoOerqQGpL+1hmXTNud3pRXUShBCDchgpdV3EOfhPZI6Z8+R
	v1FdtuM2ZydhBDZ4odPUSoJs4rS19agq/7puk36T73Q/yumVSt8DIlrYZ06DNZQNM9G1o1jL0r8
	Vax6iMRLaGbFzxVPXHBFuPSHkaGs
X-Received: by 2002:a05:6402:a58c:20b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-68f1167af2cmr64354a12.0.1780554232905; Wed, 03 Jun 2026
 23:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603223418.1720035-1-seanjc@google.com>
In-Reply-To: <20260603223418.1720035-1-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 3 Jun 2026 23:23:41 -0700
X-Gm-Features: AVHnY4JeGI7qmS9M9lkkb03_Ky7_F5xReUD-psNw1ArQMrhm0pdHLgel1z9dMIM
Message-ID: <CALMp9eT2mBWgX9VntLJcRYDCeMdLzZwzmPbHrbcM6CRL2tYT0g@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nVMX: Fix ept=n bugs where KVM runs L2 with
 guest CR3
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 3:34=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Fix two bugs where KVM can run L2 with a guest-controlled CR3.  The under=
lying
> flaw dates back to commit f087a02941fe ("KVM: nVMX: Stash L1's CR3 in
> vmcs01.GUEST_CR3 on nested entry w/o EPT").  Past me claimed:
>
>   Smashing vmcs01.GUEST_CR3 is safe because nested VM-Exits, and the unwi=
nd,
>   reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is guaranteed to be overwritten =
with
>   a shadow CR3 prior to re-entering L1.
>
> which was and is true, _if_ a nested VM-Exit or the unwind is reached.  I=
f KVM
> fails directly, vmcs01.GUEST_CR3 will be left pointing at L1's actual CR3=
, i.e.
> KVM will run with legacy shadow paging a guest-controlled CR3, which is..=
. not
> good.
>
> Note, the vTPR fix will cause KVM-Unit-Test's TPR Threshold test to fail =
when
> run with warn_on_missed_cc=3D1:
>
>   FAIL: Use TPR shadow enabled: virtual-APIC address =3D 8000000: vmlaunc=
h succeeds
>   FAIL: Use TPR shadow enabled: virtual-APIC address =3D 10000000: vmlaun=
ch succeeds
>   ...
>   FAIL: Use TPR shadow enabled: virtual-APIC address =3D ffffffffff000: v=
mlaunch succeeds
>
> due to KVM actually accessing the virtual APIC page.  Given that I'm pret=
ty
> sure I'm the only person that runs with warn_on_missed_cc=3D1, and that I=
MO this
> is firmly a test bug (e.g. on bare metal I'm pretty sure there's guarante=
e
> VMLAUNCH will succeed), I don't see any reason to try and make it "work" =
in
> KVM.  I might try to figure out a way to make the KUT testcase play nice,=
 but
> for now I'll just ignore the failures in my test runs.

IIRC, the tests in question are confirming PCI bus error semantics.
Why would the VMLAUNCH not succeed on bare metal?

> Sean Christopherson (2):
>   KVM: nVMX: Move vTPR vs. TPR Threshold consistency check into "normal"
>     checks
>   KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3 when EPT is
>     disabled
>
>  arch/x86/kvm/vmx/nested.c | 86 ++++++++++++++++-----------------------
>  arch/x86/kvm/vmx/vmx.h    |  7 ++++
>  2 files changed, 43 insertions(+), 50 deletions(-)
>
>
> base-commit: d4bfaa66fa171089b9b9fb2dc17af9245f2b9b34
> --
> 2.54.0.1032.g2f8565e1d1-goog
>
