Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C354248D2
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750418; cv=pass; b=PJQ9x5K1SFutFQ6R64wVwNZhFFixNrlEZWqHvaNKDUPXaGiq8y+TXDseeKMUBvQ1HxWLq2t8OlddWNPcz2o1iOv9QYIBLvkeYPaz1d8seWPmwfRoX++ejNhzGOn1QNJNrK5f61QVIPtFMXaJlU7MNmhwkl9eT5xRfufyepVyZ4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750418; c=relaxed/simple;
	bh=QNKIrN2lFifU3ViEQu+FhMTw527yCyM+xc+9C4IKjvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4R9pyNs4j3UezKjIz2DV8syPAvsXb0KEGcJPsC5mj2ykmKn5dBEWrcMote96lAqxz7jU5TwX/H0w0Z3btV2HEdIEY06iuyuth7n8SwMuGiWQGYun8p3KExJxfTbsLbUIfPTrcAOC4sdxvu6KVkdqAcfn/8z9yr4Nelnh22XE1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T27VMRxD; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T27VMRxD"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a1f792efd0so8102881fa.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 06:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787750410; cv=none;
        d=google.com; s=arc-20260327;
        b=dzBq/+wKf8ueD/jG3JgHl2nbpCifVqqdtpS97bFumBuc/IgGZLm1zotPCksMtg2MMR
         SmvUmxl2vK6IFDVxWjA8/gWCxmfJvHJlc2afW4q9Y/HYcGCUjrh71CJFHMx3uxk4J+cu
         voEMOaBgJIzJhuv+FwsuSG0MO3VmfhOj0H9OeIle6ohY21p20l5DMLZE6engG/EtdVKt
         m7+u5k6aOU1VGFALbv55SQzhUJ6V37DWRwYipH0SzH8HOdgWNfOiJ4yym3RpVR9R0g62
         Syqyc77XiEH+elpj4a2nvfDQ8umQYhEyx5CAvdDaZ/irHVp3lRTWrPr9GOAJxegfpWSK
         ffHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pH+dFL7dSS05A0t4Ra0NluTyTZw6F8KQqawmeG8hNcA=;
        fh=9xAeQuuqDGIg5RnHHzfMjlzJgtPJ2BEwh5HWqgMbcFs=;
        b=nmSmqjB9H257h8pmhjVzPnt0CytaznvfE747TrV+pq0xQ4XZLLvGqdo5AWJ0XRIpo2
         D1tDSTmJeL9YEgr8qdGNo+l3HuI+CfTqvpAzEZ+qzQ7s8hheyk5Y2WBFZuQeFsla3XCv
         Zq0Z+KApPY4CU3UO3MObBHK7djPZIpkLz0Qsd9sSZ8iCWmfcWTeaDS18hXQVDqE+wPht
         B656gwSXBmQc8zVIkRyLBRaT7GKZHp9tA74iNq29N9Dqz75Krce7rUbIvHk+l3XkXiTM
         NaSiqkdIYe7TxQCuiSjiIy4bbCF+UgJirR59YU2xUgp78bvg/N9FLYlyswpW0v4wldjT
         RU5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787750410; x=1788355210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pH+dFL7dSS05A0t4Ra0NluTyTZw6F8KQqawmeG8hNcA=;
        b=T27VMRxDp6KHlcAVyfHlF+VJ6Qj/4bMbdXy3tNzLP089HcmxUEN2k2k77q79sJFc89
         bAvMw3bj5sSc+j+rVfh6wakexdvTo1+ysxcXiGPoeNX4mRbcXsewsKaqH/IA95HtlM4a
         VPsEd06cCv5BXBzmLpZ1da+y+lBhyZYWn9QX9w3R2P2KeHQlEArp6BaDK3PLXeKiO2pM
         uCxfj7JS0pI9HKNh45bU3PxvocNqHA47gj2qZ9AxTchMPKanTToiDjbvfQsAe16bq7h8
         HIsjLmyApQIsUrqR+HLzAg1dFJQf1mcUsl2Y5C61lyV99Sm53oAlnLpekkW/JUP9DddK
         0F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787750410; x=1788355210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pH+dFL7dSS05A0t4Ra0NluTyTZw6F8KQqawmeG8hNcA=;
        b=aqIN20lFL/+szzoK5TUkx0zPJAaAHJDiReqcOjKFr82BvAK0oOoNLur9obrlaOVXtA
         /acBQQtDDFyUNjXkpf3l62t70p6bPLBIjIdKHHUkBnojHhW2YUY4ZHJenAN/rJS+5Qhd
         CCyZR0k+YXcCh5lAmd04li3Y9BBk2w4HfQqfIrRJtz3/0i/jMKqhY7kM8L7rxTV13kG5
         xfHPlzogi+r+4Rck8mGV1pe2ajx9VbbE4/hV8xqZTDMJli5p8vZ1wmgY46Fud0O8krOH
         pgT6tEqLI9/N52YNjliNwPytPg2Wc7AhZboN8n14HQVbKJrqI/vuOVLqUmeWtqcikhDE
         wB+g==
X-Forwarded-Encrypted: i=1; AHgh+RoSGP164AN7UrvwF99iKAxctUIzVC70nhRt+RP3UWHFYTTPtJd9aU2jFLK9ZO3yxM6YFWI=@vger.kernel.org
X-Gm-Message-State: AFuF++lPTZwn6RD1nZNMAzVocmYD4XaHOJLtEPt7vxuo7ltsLb/YjsSc
	A28XMpVTCtjS1OE1alwLHRhqJtdkD4otVp3uXRXPiRIIHcSE9TFrFoajOr4Dr/nnLGrH5/qM6nZ
	v5Ejc9hID7t8pqQxKmslqN2eupylL0/s=
X-Gm-Gg: AR+sD11Xp+TlORiONDkEZmguc+oOzlA6WdrIOD+NaBisApUsG+nKM+vmUI/Lb4oM7X7
	glF/iXyzx2E0ECYvqnqMvUWfOZ8xLce+B9vf12RZofhCmjSKiD7bDx/HO3eq64rVzYRZv++ruiU
	HfDNQJVrCAebWMn8K45Mj1b8Zbz6T2lhKDry7h+xUDV3sm3M8YVXBhfT+8mewqeb7tFLdTuIPo7
	czwSNNcVL6pbWsMZFzvVk1k5fV995IDduLKgkCKr2sSRN1uFb34bsqyfa6BSafE0uegekiDAmoY
	UKNESg6OhYw54XBWAygzKahfnva1ZTgKt7hiRTdVvFSolkvCX4y8AL5My2IhKhE2MmbAx1IAvbr
	JcAmOxLSpOjmiEEiVhz6zoqcdp2yeAtcoQxjHf2uSfY44AsA6RTNPlZMPRtqJdX/8furEuE3P
X-Received: by 2002:a05:651c:31c4:b0:3a1:8dd6:aaf9 with SMTP id
 38308e7fff4ca-3a1fd65bda3mr15964281fa.8.1787750409060; Wed, 26 Aug 2026
 06:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826070004.8100-1-sarunkod@amd.com> <20260826070004.8100-2-sarunkod@amd.com>
 <e32c1437-44ab-45d9-9534-124a9e09f029@intel.com>
In-Reply-To: <e32c1437-44ab-45d9-9534-124a9e09f029@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 26 Aug 2026 15:19:57 +0200
X-Gm-Features: AcwNN1WbGq5_aFrBjMF8bc11mRGfw3k1WkpRjRJRN2DetDqB2igsmNpygDTr4cc
Message-ID: <CAFULd4YFphkN4M0a_gC=vxN8Xgh4WWBGPo8dO-o6A3v9RGX4_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, vasant.hegde@amd.com, 
	suravee.suthikulpanit@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:30=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 8/26/26 00:00, Sairaj Kodilkar wrote:
> > Extend the existing user CMPXCHG helpers to support 16-byte operands on
> > x86-64, using LOCK_PREFIX "cmpxchg16b".  This mirrors the existing
> > __try_cmpxchg64_user_asm() / cmpxchg8b path provided for 32-bit kernels=
,
> > where KVM needs an atomic compare-exchange wider than the generic
> > cmpxchg helper can provide.
>
> Please take a good look at the Sashiko review:
>
> https://sashiko.dev/#/patchset/20260826070004.8100-2-sarunkod%40amd.com
>
> It looks like the "A" constraint isn't one that you can cleanly mirror
> from cmpxchg8b =3D> cmpxchg16b.

Actually, "+A" will work for 64bit targets, as long as the variable is
128-bit. The comment in asm.h applies to 64-bit values, where on
32-bit targets they fit in eax *and* edx, while on 64-bit targets, the
64-bit values fit into rax *or* rdx.

This is documented in GCC documentation:

     =E2=80=98A=E2=80=99
          The =E2=80=98a=E2=80=99 and =E2=80=98d=E2=80=99 registers.  This =
class is used for
          instructions that return double word results in the =E2=80=98ax:d=
x=E2=80=99
          register pair.  Single word values will be allocated either in
          =E2=80=98ax=E2=80=99 or =E2=80=98dx=E2=80=99.

And can be confirmed with e.g.:

__int128 val;

void foo (void)
{
  __int128 _v =3D val;
  asm volatile ("" : "+A" (_v));
  val =3D _v;
}

which will fail compilation with -ffixed-rax or -ffixed-rdx.

That said, the approach with union of two 64-bit halves can lead to
slightly better code, because the compiler splits the value earlier in
the compilation pipeline.

> Uros, any chance you can give these a good once-over? This seems to be
> just the kind of thing you've been fixing up lately. It would be nice to
> get them right the first time.

Based on the above explanation, these *can* be copied from 32-bit asm
patterns. Even "q" constraint will include all integer registers on
64-bit targets.

Uros.
