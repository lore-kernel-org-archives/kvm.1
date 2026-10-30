Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793318458;
	b=Zm/tBHlo6rwh4uell250//fgfltnMMFE1jJPQ39J6qwWZeq2bUu5WfZQoepJAgNKATXS
	 8f5vZwGfnJTnwzq7iNDeQNe9cAWkG9Nm8OCyeBhNWTf2KcnKCxCvROE5WRaCV+T3eT+e8
	 ptjg4wyKi/w8uKAfhW3r00lCsGMk/qXiPz+qniZwNUsWAjKFdjioMV7TVSeKWHyTtd3Jw
	 oPElZePLtQ28bTsov9RwaK1dGegfIwM9PKsUr4UTpmzfiEPN/FIdx4VMi6V1lXcgE7QmT
	 VnmJh3l52YTbVUnJ0hDcNPqxH1aQDrESMsTUuTaIcnYyyn4t0bt/DlxUj8nz8UgrPWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6AajOicrvuRgSKCOUIMtr9ZDlZu1f1csRJX+CeX/PXg=;
	b=0nj95zVsiW1SmELP2aksqZ026ogI2nN4lXCbQCaLbt3s00EQ9GV2+omlRlZjtpbGOkOH
	 6l85LO+5HLlgwrLgLy98KN+C/l20MEEp6Wp+FM/krnEcfjj7zLUwSVs2ERKXEZ016Eqkp
	 +9oU0LKkiBVZ/lj05Nj+yeyxaupvHv15kkUdbIFQBFg1VMevUqFsVYayWDIbmFg3UqznQ
	 71dS+bjImltAZsbI1iYYAVmWUqyIBYjEikmfvOwsgDcYqZCbx8Cf3IUkHP6yuecKCtQ9t
	 sMTJdG/cY04fHjNMkkW1fI+uQs7a4qSlBHr6RaNjl5aXUGnR4G8mcU+rWhaF81MmN6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AW1HInfw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF6606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 00:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEFF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AW1HInfw
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so2492a12.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 17:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793318456; cv=none;
        d=google.com; s=arc-20260327;
        b=qYf1ahZ2c4HV2IHaY4RNWUTD9gfhaCjUCshqmm9nAMhrFiWcb9R+tIRuLjYyHRQt9E
         azyx3Xe+NOmImxXgYpWq0YNO4VsRYGCl3qwk/vnzwsO4quVH/16wG7v3wuCx++DBJLdE
         DjItnqEHjDowinAh7zh3JBzy3I2KnNISV8BMzOCudYp/vlNyNDvnpFmWCI2gxq2VGaR2
         SiF86BAjJuyMSvVQwPhny8VybUQ1B7XkmfjDNGClQJ82x0WDydaZToBr+1F7X61ptQGW
         zlrUt/Ydks8FIsVJc6eLVEEawh+m/1bOASCpHZLH/MYDjm0xCk82FDGviEtiA3udo6H9
         jIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6AajOicrvuRgSKCOUIMtr9ZDlZu1f1csRJX+CeX/PXg=;
        fh=xktS1cydym5mlYKZJb5etHoGdYjZhnvXYQqq6tQt9fI=;
        b=EVpDbTASMK4+SzPQYlHy//tuvF6gxg7xgm5cgqvQC39r3rSuVZBctsqZq+dRqDnqbb
         Gdh7wfbHSuv4rQue8Y8eB8lqOJ9K/vbh+sVkAsBEsYnTRV6phsJP9B9+oS6DdDUqCmIK
         ybJlvO62dHycII/TV7X87LlIqrqB/oG02U+bO9EhL5+f8SCfteq12R4ZrtWzFtvYaann
         DJwulW0Kli3eY34+07Az7ytAnm9mzBvLguwUgVCgTZEbyi3psh0TfM53gBh6HRRbiLVh
         6El+P8SnYvFcscQAkIUvQx+tyMqJeyLluJOZfkk9Jzv5/9u5i/f59M8nCk6SJYD0/wvC
         7YKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793318456; x=1793923256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6AajOicrvuRgSKCOUIMtr9ZDlZu1f1csRJX+CeX/PXg=;
        b=AW1HInfw6hVPfoRvD736sYB3zTE0cSDxnVw6yygthKUGTF4onkFNlGmz4/caAqgUU3
         SDwEL5QPayGRF6LFj2d2Yvse1adS39hRumxe2SFEHm5nGZYUo5Ma7D/hvm5HOuoTJYxH
         vLMH4gHyoAjN2cMOL+tNZbe/vcN1I4XdQN+B+dnDclu1g6hPdtWxTTLKHVX6SOhbm1nq
         WDci24T9Kih9hvtVH4F/Oc1Cu+7+rDtAxm1UfsuTZs/TNYHzzBx2cCIZE/LARAvKGlQi
         lJb9LxGzIlOhDcTPXT9GBq2MgmvebgHNmW93Xdp7GyGMYeaCS7FMN4Roth16XZtyV6me
         TI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793318456; x=1793923256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6AajOicrvuRgSKCOUIMtr9ZDlZu1f1csRJX+CeX/PXg=;
        b=1ytWlD8PKjjK6LPKXdSJY64NAfH385Tf569jPFmPb4RtgC7Wnct0llfVySCQAbfqe/
         dVM0/xs0IXEJyU+E9jM2eOZqofiBUwKTHBzZ0YASf26xeapD0EjDNjeteeVsnjtt/9c6
         teFqAFCdJLLaGRJocwQQZ+9hbXlUkfSLUGKhe+t5DLVgRGvk2cBqCP976g3m5EMLTDg3
         4+GJUMmzoqJq8Zu0Ho+/vcAZZtkAa89QzTWsCPQjXC1QXwvfPyUzMGfAUHs2zsv/Vxgi
         piYjWpCXXtSwQW8ugy4Z9BansDFFSyIX1+7aOA3r+QJSQy4fIRWaFkEBbdJ8T2sLXAFk
         BVcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzr5hIUhhmQu0KiU11NrIF6aJgd7p85y4QmDdZoKUkB5v4XxF8iVUFlB9j6w73A/4YZpSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1+6+k7Ivh1410Z2K6YxIDZtBP0Ry0uJxrCrX6oB13A7jyp64L
	rL5TckPnK9t1IXMlJcyk9JUnlOy/THQHbk69HCDVJXSadPy4SzvkOo5eJADL/ySgDJBJ4nA58ok
	7GFdL4Fi73y/Ua8DKFhhj8T/yA1LsWv2ZNQ11xMUc
X-Gm-Gg: AYBFou254bvv9KgoBOkKqKYQWcyYx+XyatFkiJg4ZoJ5LBGuRyjzTc7XxHp2KEJTQiT
	7aH0ejF6FN/o7JOnKKlCY/Ogk+1xB1FofDo5rSIua+MyePQsxOGB9AvbP45Gb8C0foBl1zJfXc0
	7Zbc2uOUobxceg/tXxDhyCgNZclUpsK0mBdcQB6NF81o43RzK61rTk1OKLygdnWhm/HD/aC7jfm
	pl/cKDJ4CuSjaQro77kD50gADC6O0my/EesuBeR8OqQHvwjcoCYpNHsMhjxZdh9l81yBFtkDsYp
	MzRVfva5+VF7wAEul+LYQJ07yFIIvABFT7PyMZWh/3H+09tTaot//YjJuO6F8GXvWZm8kMb0SmA
	ZunSb2kExZkfc833REAzI8CrlOEkQiUFFV1mlZ6QaIMm/xPC5+HQknc1Sww==
X-Received: by 2002:a05:6402:641:b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b4b10ef524mr124485a12.5.1793318455914; Thu, 29 Oct 2026
 17:00:55 -0700 (PDT)
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
 <CALMp9eTKXa9v1TxJMPrE-tSXajwJCErCk=g34dOPJtG057t5mg@mail.gmail.com>
 <auPAFxXy4ulcK_jq@google.com> <CALMp9eQdtvjQkdgnJ_NTt=2ArdzUtqqzieXLccv9Vb_My5G+fQ@mail.gmail.com>
In-Reply-To: <CALMp9eQdtvjQkdgnJ_NTt=2ArdzUtqqzieXLccv9Vb_My5G+fQ@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 29 Oct 2026 17:00:43 -0700
X-Gm-Features: AclHuK9Gf9FXwfveb_3CfkAO_qfPf7-qk20lAd5kJcyEb-CP0c5NZ2eSdTbAAeE
Message-ID: <CALMp9eSgWhTFi1vxxnN=1zV4mRVsKD55F=37yg4LmT_xUAc_Pw@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: SVM: Check EFER.SVME before updating MSR_VM_CR
 on guest writes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:04=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Thu, Oct 29, 2026 at 2:52=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Oct 29, 2026, Jim Mattson wrote:
> > > On Thu, Oct 29, 2026 at 2:19=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Thu, Oct 29, 2026, Jim Mattson wrote:
> > > > > (Host- initiated writes are allowed to set any valid MSR_VM_CR bi=
ts.)
> > > >
> > > > Eww.  Why?  If we allow this, then we'll end up with the mess where=
 the guest
> > > > can't write back the current value (if userspace is being weird).  =
I get that
> > > > we want to avoid ordering issues, but there's *already* a required =
order here,
> > > > unless userspace ignores the failure from svm_set_vm_cr() and conti=
nues on.
> > > >
> > > > KVM doesn't advertise the MSR as something to be saved/restored, an=
d none of
> > > > QEMU, CHV, CrosVM, or our VMM appear to save/restore it.  So why ma=
ke trouble
> > > > for ourselves?
> > >
> > > OMG! I didn't look any farther than the obviously broken svm_set_vm_c=
r().
> > >
> > > It looks like svm->nested.vm_cr_msr controls nothing other than itsel=
f.
> >
> > LOL, nice.
> >
> > > It's just 5 bits of storage with some weird locking rules, and it
> > > resets to 0 on suspend/resume.
> > >
> > > What is the point of such half-baked support?
> >
> > More than likely, so that older kernels didn't crash when writing an MS=
R KVM
> > didn't emulate. :-(
>
> You're not going to let me get rid of it, are you?

LOL! Even the 'LOCK' check is wrong:

 if (svm->nested.vm_cr_msr & SVM_VM_CR_SVM_DIS_MASK)
        chg_mask &=3D ~(SVM_VM_CR_SVM_LOCK_MASK | SVM_VM_CR_SVM_DIS_MASK);

The condition should be checking SVM_VM_CR_SVM_LOCK_MASK.

Well, at least it can be used as a sentinel you can poll to see if
your VM has live-migrated. :)
