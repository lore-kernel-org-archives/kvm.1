Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181534A4981
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999565; cv=none; b=YemRAuBp5Oy+vApbgLq6cd2h5S1FXVU7QT/HIksWJ0tR1J+SGuIc6VGWZQoRtTf/b08niYjlZTpTZCxuX98rJOV0ejFOGiToY3a6dyACadjLbvGAkzaOUPIOu1TykpiOf32ZL9usm10dtu/q1NizESM0OkBBIAYBV0+li9FMvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999565; c=relaxed/simple;
	bh=2eJm4Qlbcv63yRhYp8LKeIfnT6D1XcAZy2F28IWxQIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cOOLZMxGpY+RqPS/F7+eFwFjZDNWhKu07LNYXiXZiokudemmmQz3d5eoR9ZtpzPunBPi/Lh0q+UbzNynvPZQOJ/PvmhpiZI0qG/5qfMGlK5bhozgUjVNW5qo9xUN0QJOFGJcTGwztA8YqCOG9tIaSw9mLPUGT/KvrOXGsTkvESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVQG/ibn; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVQG/ibn"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d7443e0f0bso57391955ad.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999563; x=1790604363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2SNrcGbCmwVp5rC+pI8JTwzDzqFP9LyCEeRjh8ThPOg=;
        b=DVQG/ibnrvEMizR/ZR3AN3CK4Wrbi5L96YI2dcIXkU2pFtMqBavry4S7EO3gVrJudk
         fzImUQD3JxuHhf5VqZOT7NhoK88ro/+2RpyRlcGv7RekKGaPgMo/ZR6W3juLsapgwDYW
         LIg1TZ27n20mJLhjvizutQJfx0H4NyFqoKcKxrXhLGqDWpOtwAs0KNVrdJ4ujm4PlQkm
         mgApY4XEY71mKWkRnUDSTTS4BEXTc4kAF2iBoOrSZRkvMbCIx/zpZvFAF4pZZeKFIcSR
         13wSKIr9FLcffcpSHcXzyrhc1svm+M4dhVVaOWKCD2R9DLusGQdtmfIyL33e1+FvYImZ
         uEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999563; x=1790604363;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2SNrcGbCmwVp5rC+pI8JTwzDzqFP9LyCEeRjh8ThPOg=;
        b=03pr818BpflYMdSa69Wl2+d9KTcHLqF1QVN1o/w24jM256KvdHRr7s/+xbGcH7IrXM
         TvvQ/7oeWHm4JIbhWrzw7PlaTlW5jpNT5H19SwLxcf/c8jTv+ynK4Dx+BIz3H4dS82Nf
         70EFjqxKjGzKq9gGiZzFAdhd3WliPqZ2NJy5jyIyVHy+rXDH/VcMwJz6rQavObs3yk8z
         aJHFehvsb/nsLqPqroCGFJsR9t6WxItF6juUc/m8dV+l79j8ATYxQ46h9ebMzLNur3FK
         251dzWp3SOOELzX69Kh0Fk/xtItQO4kzYr/H7aNYcPaxkgt2upV36LjohwmYCPcJTKXf
         CZyA==
X-Forwarded-Encrypted: i=1; AKwUvBw9movG31258BKlhiozK9NSbWobTgldVr0hhpwxa4Q32lqNlLa9Au3laA0nzibbnGzEBMw=@vger.kernel.org
X-Gm-Message-State: AFuF++knigHE2PKJNx0y2+Uv0MRHj8V4AflHLqg99Yn2R4EZYKfe9kX4
	npDfGQ8u+YWBAdaxkKIKdWPsDcJpIJ0q6yiGf9sZfy/NAEw+G9F6AzCdDg8gT0uLwmVXyKQ4XW7
	6Ug9W1Q==
X-Received: from plld8.prod.google.com ([2002:a17:902:7288:b0:2db:60a3:afae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f4c:b0:2dd:c170:2d4d
 with SMTP id d9443c01a7336-2ddc17034demr110471435ad.24.1789999563212; Mon, 21
 Sep 2026 07:06:03 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:06 -0700
In-Reply-To: <047d5e3a-b64d-434c-9a40-140468441de2.hao.xiang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <047d5e3a-b64d-434c-9a40-140468441de2.hao.xiang@linux.alibaba.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999687461.714438.14645888024741570716.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Rename CPUID feature bit AVX10_VNNI_INT to AVX10_V1_AUX
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm <kvm@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, "zhao1.liu" <zhao1.liu@intel.com>, 
	pbonzini <pbonzini@redhat.com>, "shannon.zhao" <shannon.zhao@linux.alibaba.com>, 
	Hao Xiang <hao.xiang@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Sep 2026 19:54:51 +0800, Hao Xiang wrote:
> CPUID feature bit AVX10_VNNI_INT is renamed to AVX10_V1_AUX to account
> for additional AVX10.2 instructions separated to have =E2=80=9DOR=E2=80=
=9D sensitivity
> for platforms which may not support all of AVX10.2[*]. This CPUID bit now
> applies to the following VNNI instructions: VPDPB[SU,UU,SS]D[,S]
> VPDPW[SU,US,UU]D[,S], as well as the following convert instructions:
> VCVT[,2]PH2[B,H]F8[,S], VCVT2PS2PHX, VCVT-BIASPH2[B,H]F8[,S],
> VCVTHF82PH.
>=20
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Rename CPUID feature bit AVX10_VNNI_INT to AVX10_V1_AUX
      https://github.com/kvm-x86/linux/commit/674717509d9e

--
https://github.com/kvm-x86/linux/tree/next
