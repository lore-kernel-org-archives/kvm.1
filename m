Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793310391;
	b=Vo6BloN+OTbbbVQqXatG0fxs3W9fOtRaZmkqgy+np1aXaLfkMItG3dX7g4zzlW0bVaMd
	 WpOXWQ8+oT7oQw4ZwGkObMd7xI/cjEAd/jP775XiExNwI61YpEqHxsHum8yP1weRfYNds
	 w8hGVEwpX2JNZ9QN8HhknFj8HtiblWW+wSQ/VDABdkVLsa3xaD2aRoCrd9XJ0HmLu6XNH
	 hmZSPr21F8Hk8incX1Vbchqh7O5lS9jzdGqxXV9OZqLoKdIOOI6Cj+cB6wRaDrpdGpeIF
	 lNGIoSUux73De7lmvHbchpdWxvy1ej7o9kMNo4mrON8H5dzrRR4Z50P9VN6AOn4Q6wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JYWLRbAAA76l2zIS8Fp/p/vFZPUiy9vOWrroeHgM1YQ=;
	b=bfh3IhPgAsnh9QZcLmnH9dQla8+JY+Mh+SGQK0DBjo1Heqca5fs7ROiTbCNbWZeTbaQJ
	 j210J7DRGH/gSBD2fEBDdZnWIHi13ojFZiVqDjlfgqLmMFErBvTMoUoG/p5E5uizxkd4R
	 HrdjFQIkX1O9LBgIKSs5Y35M2sNhDWGU47ohIFApRghKlLNZUCN+AiHFRA6U3nXnrsxZa
	 TckoeKyXKJtd0qJi5u9OcqSzJtoJMQua5srd4u7OXJwUOcCVBQl3ovt4ZW7o1qH+9VthC
	 i+4lMODOfERMxivj83dJnXMp/NJSkfBTB+rcUTd47DZTMjqteshhG7egWs9E6IsrbCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I4dlR2qi;
	arc=fail smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3309606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 21:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3309606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I4dlR2qi
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso1768a12.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 14:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793310389; cv=none;
        d=google.com; s=arc-20260327;
        b=atEOXHWJns5Sk2GKKKv5eJ7X8cyjn684fE53SHrdMH0dXvQwWLJYiS1U7R2FeX97G5
         2wRnEvW89WHzJCOHzWZt5WuvhFUe2qqFmB56ggNuX074cYUxX7fjP3FfPKCcWb3sG/N5
         0pWDL/hQbKc7DOfaoBRcon2YodEsC3zgq1Oz/2BshDZxLUkGclSQ62BNHTy0QQfCs/xN
         uwD6K1U84b00yPkVwrRe9Sb7SegMPDjc3PNeRcaWjxqDlBQqziUA5Z9RZh5TSL1Vn1/q
         2Dsu0a/HLOiM2OPiEf7NNaAXXAFcWYlw4Xv3zqfeQZ59TGj9C5ZswWw5Inv6eUcsviXZ
         OgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JYWLRbAAA76l2zIS8Fp/p/vFZPUiy9vOWrroeHgM1YQ=;
        fh=0TSkiP1vTlScpujzRdv3nYts1xzioeWpLgZMV+xwF3M=;
        b=iMtxGY1kXeFr9nlFzdZrJm7t9S/eaczFU6T+UMCx4IwszY9/toTsYijLHk7QShz+Xu
         ovHPi9SgZ9p3ZkDBbB+bd8FcWouDqA2i3Xv74joh0y6D5sSqIfomhFtazi3ImHFMKzfd
         BDmGWIGx0I/0puP9FnuKQB0uRhl+ULod2NsuwJ1XiHM01FR6zfdu6k5KcqNWZDSI+Em2
         7ST/I9YI9jr3Dl+0A7V96nRTbMvwiIuNzdI0Q68FB/kZGUrZxZIQ0zqH2kz2UhCuOJY9
         M8OqsOrJrQRATcmY+NcKO7tCHkKRs2A/ql6aoHsPxDzC9Vi+W+iECIbLjGt7eU73/lEM
         zPUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793310389; x=1793915189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JYWLRbAAA76l2zIS8Fp/p/vFZPUiy9vOWrroeHgM1YQ=;
        b=I4dlR2qix7SJc+PKkii8t3EDI4Z1KNkJtuR7HIXzCQGlrGjd05cDkYsOP1Hy2gc8SL
         Dx7ws/yC2WOhs1JcQ3A/N0YeCBWkN7koRnbZPiPgDxgasN4XOxyJYID4szwRS1IMVvYi
         LaC+kGQz0BCU1J8SCGHJ7uht81XdB5VOtE9MRTvRUBv19uHqFg+20+xsNnBIBA1kJrhZ
         t5LN2BTVIfjEHC6wfin9bGH+9zy99Wrm26cqz09K2LpPwUMS4L4NB6MPSeeHCrx1/aBn
         mkYwEkxU8/LNldnQ74li+oujcyRvQLfzMfjQVjOj+Z2pk8M5iQUcYSy7EA9TwI03aV0H
         UoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793310389; x=1793915189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYWLRbAAA76l2zIS8Fp/p/vFZPUiy9vOWrroeHgM1YQ=;
        b=sxW8N67axGlNPbdf8l2on+3yqcoQR8QFsw4vMp1PJO365j4kqqhzlTGdl6jG6maENJ
         c+bbuFrDa96/u1aUUldBPu14CO+nBYfjEZ9TeOD6/L4Jyybam19l6jk37h/Ml3YgbA94
         PSfyppmUm11YeiARUzo5BL4VqDPTr0kf0VHqKiGWhET8tgRBHUxgyYpHhQGW2q2lNXhj
         2QL3CShrpBMKV5mUb1FrK9HYXOgXd4lGDno3kAo3RfAYpHh7Pe9rMH8wVmK3J2dUK45p
         79aehv7PFdbKRwc0ziNOcfk14GyehY+bwW9AzyKEAyW2VOBnpaBUJzm6uInva+TrHbr5
         phrg==
X-Forwarded-Encrypted: i=1; AKwUvBwGRGAtjNdb/12o3KDCGNQbSDq2geOZc5gSO0fVv9kjXeCoNfuDemMk4hT3cYj9Xu7PYjI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYMj9yOapHndRki2HczX8rI3T7pIY58wjtEv0dakDPYO6yKSy+
	rXCiZzS7nN6xzWDBb4WRc2wVPmOctX1CkTJQKqNUQic+rN4HGVBFzPklOpFehfomNCsLs5Qk5Wc
	VtYKj8OuxWLEbtO0VmHJRMTjjeQcoJgczCdSFuzNQ
X-Gm-Gg: AYBFou0OHiTsU8PQd45PWGfHKUHOdJDVc7Ooc1JtSN0WncSGYZUmbjLKH4fzCwjhhZ3
	cdRGMVYFXcDxdoijiT9sLnO9T6P5MjGiwvywa6tXg5PwmhGrM3+eybCfivObGuEq+sfBJBnVSF+
	o4COiWNE+1hypPnR5vyM28aP5XA2kDLGZoqiRG0yQL/jgoNRjXXXruhPc1nm/WfHvULP5/uNawM
	X+lNfE6toEHGCiAHiJbX7v/NT0KD4AKQIXCc/IUUyJn29vN/WCl3OKL2Rg/OpxT12n8RW31OCef
	jaSzgQcaKVVA6yHRqQuR/w/SQGyJ1fsQk3dHMHVRLd2X4DIvuvfgBYUUlhZlZs5AKShPxE46ZEJ
	wZ8Ep1xZBWnq0IRTtATNofXjZh7B7zpkvS9x5
X-Received: by 2002:a05:6402:44ce:b0:6aa:b72b:d762 with SMTP id
 4fb4d7f45d1cf-6b4b0e8158emr110491a12.1.1793310388718; Thu, 29 Oct 2026
 14:46:28 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029202817.901145-1-jmattson@google.com> <auO4UueaV0mTVzzB@google.com>
In-Reply-To: <auO4UueaV0mTVzzB@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 29 Oct 2026 14:46:16 -0700
X-Gm-Features: AclHuK8NZLJIX8QRthineYRqVAWzP1LKOquD4mrybMuUOVfeI9RwEH1_rstJFFw
Message-ID: <CALMp9eTKXa9v1TxJMPrE-tSXajwJCErCk=g34dOPJtG057t5mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: SVM: Check EFER.SVME before updating MSR_VM_CR
 on guest writes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 2:19=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Oct 29, 2026, Jim Mattson wrote:
> > (Host- initiated writes are allowed to set any valid MSR_VM_CR bits.)
>
> Eww.  Why?  If we allow this, then we'll end up with the mess where the g=
uest
> can't write back the current value (if userspace is being weird).  I get =
that
> we want to avoid ordering issues, but there's *already* a required order =
here,
> unless userspace ignores the failure from svm_set_vm_cr() and continues o=
n.
>
> KVM doesn't advertise the MSR as something to be saved/restored, and none=
 of
> QEMU, CHV, CrosVM, or our VMM appear to save/restore it.  So why make tro=
uble
> for ourselves?

OMG! I didn't look any farther than the obviously broken svm_set_vm_cr().

It looks like svm->nested.vm_cr_msr controls nothing other than itself.

It's just 5 bits of storage with some weird locking rules, and it
resets to 0 on suspend/resume.

What is the point of such half-baked support?
