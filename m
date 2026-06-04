Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903003BD228
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 05:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549808; cv=pass; b=GmqH6w886YNCuRVzgqK+epD44oVJrB3v0HuboMymWlLtixD+k3BQMJ9KLv8vUBMqzCYE/T+Z4FTJTWViDPUqRtii3YF51KMI+CVvQvIJyHoMC3+V4YCYGmMPLCTwecfa0ChkqqVOyvhOKOk3MX9fyzoHZu038WZ5VxawaDm7M+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549808; c=relaxed/simple;
	bh=S35ZVWeDDxTN5GtsP7ClV3ArVsjsJx5Z96CKf1ahOUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0Oo9vvFw+CQDu7UDlc8SkJM5PfzVUDY8sOGrXOs5YYYRpZzpjN0rum8gOGSrrWKleG48ZovxpCv8Zf/WvctulZGaBUnqF25iggaIU2/M2EJbhBfteEt1SqQGLu7MNvZKW6nddc3ip6uRW978KZX3v0xywxY4EoJs/tZGqphe2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PGBewMit; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGBewMit"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso6293a12.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 22:10:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780549806; cv=none;
        d=google.com; s=arc-20240605;
        b=KAnLsbHpeQY2zcuB2mXvZYle951q1SpVciWFGNgp3kwZv9xA02wa58jsSKWsnEp9iU
         0/s8hV3cLuAAT2F1rS1yccUGKd79p2r3zIwzLo9jEGkKEIAnfxStkUv7s5jXp6o4+17o
         iGq5+t4FEM7k/a4rhnOK2tX4YKE1NIrziXgHYq4XlEwJr1NkxmfcxIfiqJf+nO/LgcPJ
         HzHE2wOcoYKzKgoEs3dgzfQZ1Az+QdaWpXPxFxSiUeYCtBJzQiUG2XFmyWSxY2IskCWi
         uFbztpWowmJmbkZ4SeliBvx4rtecapOfSjZQ+6H/onOlmqTcmKv2aOSiPxPoXxsNq4i7
         cp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S35ZVWeDDxTN5GtsP7ClV3ArVsjsJx5Z96CKf1ahOUo=;
        fh=7U6RgtWSRCBrU6hz55eMQwMORKfO+P5ilDqkBpleveM=;
        b=Sgy4b/ujrJnKvOD+J4cw4XF6QdHaRo/Lxyey0kvVhtu9UW0rKJhjgKKsSbdUBlO6au
         TNKCK/yTLtzUfGCkZSpG+whhfSThUCK0nTZ22OeqAcON19LBM0uwuDMUT7jtkwVbSSew
         FKy+CsncU4PRw5xCN4L0F3bQ0q3XFiqfgEM5SQS9NYaQHBDWabKecVALxQlD47kwECNt
         OCGizsGC6d84eZF5s1UsgpwfYLssulZqateBnPYrVfuyzousZVUFBw/kxowcRf3OKmzC
         Tt1yMUePHeAHAf+Gzpb3AdJs8IOY+YZzBAELAoiQHRFzuKwVLt+uBltzNioTzsBBSq/C
         zxRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780549806; x=1781154606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S35ZVWeDDxTN5GtsP7ClV3ArVsjsJx5Z96CKf1ahOUo=;
        b=PGBewMitRaFv3LGLrGik/RMHgEkGv6wH6hHKacvssnHQl3tmPJb3W4LuW/pDj9/1YK
         8YeTIKDxChsWZM2Y/joHhMBfNRq6anaa67PATY8Tc53ldtSn5cGcq7OtuBR0tC+Z5xME
         fR8XRlZ5GXOStkHbf4pFcgx8gXL8hF4vjtYXbcp51ITAGwHurSuzQt3dlS0+eFppcmeT
         YZOfe6PEQ/+lF/qYAEsdqFwKg72SA8XJHUDXeS83uLPFFNtWLQSD2QzAOyLqaG2tDGaD
         2gJT3G2cosU8g0AwZz8xTO+ko79z8Xo2Ohk7JUWyK7wmBh7Q4eT+7xktX3rpP2GIqUjy
         LNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780549806; x=1781154606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S35ZVWeDDxTN5GtsP7ClV3ArVsjsJx5Z96CKf1ahOUo=;
        b=BIGCxaodGn6sWBAGE53QlbjDZaoRTzbXQ7ue88g0pIKaeQFswMrRGBV4M93LpKpLg9
         3Ndqr2byQdgTEUL4G6EMtfms3SxVYLxBf0QK6pAfqcifkVcvKQEJbGgW80EpsdmJQ192
         ggpVcEkuJFrtVETycQwbsqbJsEecqx9CnRdYL55kLWlyq8nk2ZbGcMJLLAdZ1Dvn09Yq
         IhLJtP2S+Y1iw1I6XLwZ8h2h7ZZL8nblLegHb9Yq1utpH89Y5JB21AeX3f4jOPd0MmD0
         Kq53FSoq6FBbgGNMNdtBlE7dugVKBZchgD+d6JaoL5Qt8ytfYdJwgNNFQ1G5kxNHGZSH
         a8yA==
X-Forwarded-Encrypted: i=1; AFNElJ8b8Rcq25io2V31vCMK55XexyfNKL4IAvToxiz8aP2hXZoneYM5jR9KkG+XfMr3uNO/WDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxVbeYT4O+fWYF7ToTh7eh+nVWJEKAAfKcFVI/54HavxqVoPS
	f9kWfhX4EvkBk+BGy1Tpg5T08+qPklNJbFr2W9OL/k+S6mMTjCen7GLhncEczyNIEod56Jj92FP
	Rz3FKE5TtH+kOz3gdihmaLYEvwcdUIwjfBLhNXBIa
X-Gm-Gg: Acq92OEEOMyYxoVM3+4XaWkxYtourXJD5ZNWwCrdibfNlSHP5Y0W1j0Bxy7ZODSeHrQ
	nXbuUe5AJu7f6nRY0OE9Pr0KzMh7/hhF5wbI9c/iwp0OOdoJLMW4AgIEnzXZGMpzI26q21brDc8
	1wmy2sZ0JnX7v+dobFmQ9PNWwwLsPzQgs+QNj8vGhT0qh22iIMDRZngwgoJEPLbUVquEg3UcxYn
	MLU2a/FijwQNzGEfW5Qr/8/byMexSFpPXtXMpnmS76znjwqACRitIe+B9lfZLjM1HMYZ39J/1YH
	AdJ/MwyOtWiFlq0aoQ==
X-Received: by 2002:a05:6402:1a55:b0:68a:83c2:9c75 with SMTP id
 4fb4d7f45d1cf-68f1158030cmr63817a12.0.1780549805644; Wed, 03 Jun 2026
 22:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718214999.git.reinette.chatre@intel.com>
 <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com> <agPUfzbMzTU1ebii@intel.com>
 <agY6JuEJRhwpwlRL@google.com> <aga+jCVUW0d4GufQ@intel.com>
In-Reply-To: <aga+jCVUW0d4GufQ@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 3 Jun 2026 22:09:53 -0700
X-Gm-Features: AVHnY4I35ycO2NgmjczPlvA_AnXBGCMSXh6LORUscksc-B6RlXqcRzaIQ4f2KCo
Message-ID: <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
To: Chao Gao <chao.gao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	isaku.yamahata@intel.com, pbonzini@redhat.com, erdemaktas@google.com, 
	vkuznets@redhat.com, vannapurve@google.com, mlevitsk@redhat.com, 
	xiaoyao.li@intel.com, rick.p.edgecombe@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chenyi.qiang@intel.com, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 11:35=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrot=
e:
>
> >> EMR158. VMX-Preemption Timer May Expire Earlier With Certain Large Tim=
er Values
> >
> >I assume the same erratum applies to previous generations as well?
>
> Yes.

This test still fails on our SKX, CLX, and ICX systems.

Sean,

Were you thinking of enforcing a cap on delta_tsc in vmx_set_hv_timer()?
