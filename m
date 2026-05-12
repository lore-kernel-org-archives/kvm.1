Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF0F3C3421
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617501; cv=pass; b=jcgTApu7npPOaTCnU3rHDNoZySHV9inmTxO0IV+ByYTe7saFsU/WmBPMsy3QT3KWRHPXh+bSNmB/h4ppgUalA92jHeA2Scea51sZeYKM2qgODO1FYOehPKSEfIVrO6XdiF5kBU+aDYsybel71Tbraoq43CW1VVt+oa/QHRPD7lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617501; c=relaxed/simple;
	bh=p1Dt2Pau45+gr9BBZWBbRM+0pqU8mWL0SwtrndPS4cI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBzkY/+YylNEFdWlHxyMT55jiqubOQRxqH9dzcUO/seFCe8+CChgNN1hip827zIH2Xl+iUjcZLY8qBfQoDAzZ9V7JmtH4J9Rzom9sbW4HxY3ndd3urBMEnQ1151vV0Fff3DZzxppj71C/5q0segqtpWZO5ZEEXnl90LDCqOL2Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ke+HVRC5; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ke+HVRC5"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-575212eb419so4177087e0c.1
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 13:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778617499; cv=none;
        d=google.com; s=arc-20240605;
        b=fwkrtzEAeIoHocx5Ubhi2YiUkqGNxyoiTwk0xIShZGyJdsAPKFrYcdKZzn6OIaG1a/
         oSiDD5LnfGbhOJGvA2BcjIQAr+8mzZbuQU1cVvktv+EFiJnVbX6n+4WKX8ZWEYZPQVWi
         Tf/8lTgMpo8F0/AhGWwGtHvBgDC4VOwwVhUztEanfE8fYVZC3OQayHQXYYXy7Na3wirR
         VEQm2QBV95wSSdWu7XWDdYU4NSYeTpHRA1Ocmd468BDv1FZVO32r5BATCmTHQAnX2DtG
         KgvTGeD/29Zub8w6d0n9UOC0+mU99tiRKMU76mUZkF4urkG99NBXNTrQbQ3Q/abNMNbZ
         evrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6A32fFSH9OPwjkkpWNRgZBSlRVvMKc+ege6TQRAjjbc=;
        fh=asIdoflnLiJWzf54775ya7ch8uBJ1avB1St/C8QpTBo=;
        b=Oa1MTngeaqwB9pD1QeIm2qG/4vaap4QdJR+qPq9mUbpS9eQhkGaM2IF0I0nt6uL5XP
         uxMqdpgZzPdXQ79IhnWQDu8TNoOCceXFOmumCSBF+oe3quQXIehZAG10G1OTJ94lsaU+
         SEOg+tm6pzEaBWCsuiksqonhDml53ym0WE68bu8+GpRcMSM9HJZwbi2lKKX618C3XyWV
         rkmt7yRjKTEan1y+GObYSukZ7QuUE4pNIaG3ll8b/PDR2ttdWdMZw4JdEKkEXzGAUR8D
         Yb0mEdYny/49jhTJMiVFRlTwXNZ1Kmm6DTibZ2nLUE1G7gwa0Od+2ZwWz252LhDtEHXD
         Eukg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778617499; x=1779222299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6A32fFSH9OPwjkkpWNRgZBSlRVvMKc+ege6TQRAjjbc=;
        b=Ke+HVRC5Axson/fPx69NHKv1kMSMzrBpU0e/d8rzsJbl7KnfxHHJQ9SlxHQyvDViHR
         +11AAD7I1vH2/gOvjo/2wd4kAb58+JYxrHOm+9uFEufz3M5YjiyoEoH9lwE9yuGfPCC6
         HJ9jgzjz9SMi39dtgoO2zO4CPHYf3arg6EgHlLPeR3MbXRx9wQ73Q1u/jO310MRQMap6
         L+jcJ392bfxrlA5Vka1/+YRACksqbijC/+jnvxncFnlO+Z4i9Bqr06KBXUACrdUBvSJ0
         ja6+F3xGmkRERBsdjYrhqUM8K6aqJAyAhD5uojYQ02o4mmST2HrIKBz5F7HSp4rBaTgc
         RNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617499; x=1779222299;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6A32fFSH9OPwjkkpWNRgZBSlRVvMKc+ege6TQRAjjbc=;
        b=kwVIwHJvagFll/ZT0tlCrl0lhKeSnDNw+LpEOXnMgp4olQ/ZT+kcsEu/M+vhueSXqu
         mMqLr+RDyGBgup7jCPsWb6UMjsgnyeVRFw84Kl5QOZC6qrgknIWLB/qDRlBR+Xk7r7li
         MbuDVXk0tBOPOwnDWG7DNlhbWwSiIqJPqwJlqQ9RG1vh9cpJNlq1Qn+IzxTCID0MfbMV
         ht9/TGw+TCwi8VDtngmOwndYjhCpc/BjwIMSwQc8l73QwozmwJDd0Qnfl1T5inuIPAPR
         G6ir7fyD5jcmyvPc0DA1W6Smk1u1lggmy89CrlEtt3dQ11fuanhFXQ8o97C0LWqEH5gR
         YYww==
X-Forwarded-Encrypted: i=1; AFNElJ83TL/9iBq7Or+BoXoOxg4KpHWowsk5yzL2p2172E4X/zKgWjEghZlFtZ+BaBvxw3F2smk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0lLsxl6bKUhjxWLqvp1kLLGcOgH5A6iPRWsN9ZObAVp3SGnh7
	y2FmHBV6NavfCc2Jt4YqJ3t46ibOfujAnve2vkkIJCu8LZaBJfep6aVaXIPw610rnhohHPyPTnX
	VK3bqCVgXXi+NM5c9l7v8+G8kDZUyYfTycRRFwhsK
X-Gm-Gg: Acq92OH8ZopPneHUSPQzcFIip0i4aor5Vl73G7OVN6Jfv5SBJVYWAmDDIl7XnxASQdY
	rGUu6Yn3cTgR8x7PYMMr3tMLalt5LuomfQbPSYSQBec1lUYtGmiTZSE2lsBthztAaBBchQOz4OZ
	B8s8EdI/+bS07ngTArTCi5E3Np9FjlT59wgI7hp+UECV1RDjERUpZl28GwF3wYnhUw0Tdq3MyXo
	Td281jYupi3DFfVPeAT+5SVl7ahuZCUZo98ThsK3eZPNG0TFn6kdcQTVVpsdvihFFd28q+O3tWT
	79wlRKlwLVPUaWG7UXpOsY5POHXaGfRKzc9BNDf3LotipS4RReoCF5eMqH4Vf+1BvFKDlBHWZhO
	78Uba
X-Received: by 2002:a05:6122:814:b0:575:9cb5:a87d with SMTP id
 71dfb90a1353d-575cfc6f98bmr1737434e0c.2.1778617498178; Tue, 12 May 2026
 13:24:58 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 May 2026 13:24:57 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 May 2026 13:24:57 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260511113759.610924-3-tabba@google.com>
References: <20260511113759.610924-1-tabba@google.com> <20260511113759.610924-3-tabba@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 May 2026 13:24:57 -0700
X-Gm-Features: AVHnY4JAG5WXg_aVbHSnEQMcpSlet0iZdAsV7gUZdzLesUHy1Hns5TF1STKi8r4
Message-ID: <CAEvNRgHfBqqC1K7enCPX3jqWE0smJ3E0NE=kUPSX7N7g5KQrvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Fix FD double-close in kvm_vm_release()
To: Fuad Tabba <tabba@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <tabba@google.com> writes:

I agree that perhaps in this case manually setting up the memslot after
mmap()-ing anonymous memory is better since it's more explicit about
what is being tested.

> kvm_vm_release() closes vmp->fd and vmp->kvm_fd unconditionally, and
> kvm_vm_free() calls kvm_vm_release() at teardown.  A test that calls
> kvm_vm_release() and then kvm_vm_free() without a
> vm_recreate_with_one_vcpu() in between double-closes both FDs.  Since
> kvm_close() asserts on close() failure, the second close trips
> TEST_ASSERT and aborts the test, or, if the FD was recycled, silently
> closes an unrelated file.
>

Never thought about this fd-recycling case, I think this change still
has value in avoiding the silent closing of some other file.

>
> [...snip...]
>
