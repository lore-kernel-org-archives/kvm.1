Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58945388E4E
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304731; cv=pass; b=BK2LXIbKpZZS3VQ0ggWA1fVLeWGPRy3S4515MOcoi+g/mKn9LP5JT1xHpKhwwUXe09GKMKu6uhxZOAIYeeyrO0W/Sqk/kk+9LL7rZARLz3FABQRhqLIbBFK8WGsioViicYXqQ6gicKq9LDtl9kBfXzpTfFzJDEmQp9/+ErtU/PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304731; c=relaxed/simple;
	bh=5YrYFwPVh4TWTkQlI+CIig/TdkWAayn3usWZ6HaRdIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiCc/dfoIfw+EbaS+Kd7PytdxLXt2XfmfjEaVuqrBEYIS7YDPS71t5TklRcpAgTIAebV8P7A0bm8zzqhTSAXSmw9p3lJNtLui71wb+N/+uu1IUHkZkIJPW/d75DrQQimSPyRL+s0gX/BgeeYayUWonsxdqqjy6ahQ8EgkkVmlH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+OiFelE; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+OiFelE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68cb445dd5cso1623a12.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 15:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781304729; cv=none;
        d=google.com; s=arc-20240605;
        b=O3uTmMcZJ1qFRgaQqBfrJtFdkCHtXqB5fx6KmGdMQubbcA40NDo+oYLd/nvfNfZy9s
         LO8LQngvwi6C9wiG+GGRTxMAJ0AhP03D74GRJilHGmhWG/pDcjF34CGQyGPYiE2LGxxU
         gO78kT6gFJcAau29O3shDghBPzBs5YeUV9eSWmxwaispCYevawyE0W+BIZsGmK6/eYBB
         XdT4I1kmwgsX0S/Cj0/i5B7vjr9/VsmQjzfQxuP405u8BklRQZEefyQU11GViH/hNAKT
         nr21Ao1ek6wpsuQUEd0FW5dbdoCuBhXdOjsZ+zDcmd0c0PyBM5c7yIZPIJ/wAnHkwjVt
         Mhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5YrYFwPVh4TWTkQlI+CIig/TdkWAayn3usWZ6HaRdIs=;
        fh=BgY+AdL75t2CrGB90YqrIb1yZtx8YQWRJdotqySmFxY=;
        b=RXc7yY3gWIMNvnbTX5JYl3uGaqILYCQMl7sOS1QQh2acxM2OY1N9vG4CYkfVJkbjeQ
         xbhVgv51zOLgaoefDo/O5kNb6X4Yhwm4P7upn9IKOiGJq80S7VlgQUSXLoQL/Fn7pcRh
         qF15TcPxUazqwSjRSIIS545t07NA0VA1QwtZZE1+BDXew19Jgc5nk2RbvwvjxA6w6XM4
         x9P2nnL8x1AhOxQoIlUhyG3iZ8xbArMIGmumo2SZVuPx0sYNm5KX5FRTiFen9z2VtyIe
         gO20ph+mAg61734q6iHnu9XOnsiDqHyHoCppKBWaB9DyAGFaK54PqjzFekQ3aslRP/F6
         /kfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781304729; x=1781909529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YrYFwPVh4TWTkQlI+CIig/TdkWAayn3usWZ6HaRdIs=;
        b=D+OiFelEk0khNRGs8T2rCIjiAQuCdzS7g/9hFQ57zAgof5zUDHOrjdB2dKWprxhFCa
         558ZdfcoLQPlBSSDcLTjbTXv4cSb00O+uXvUHGuLcIog+616G5lRqTz/eQXLHSGGN+Pj
         H64UKRwXd5eVauh1XqxPa2/iE7klBo+iSCdix9T+t75HbL+QNaVoNNP4HvUpinbIzSd5
         45GRtQZqGyLEB+JFC6N62qB5Fr1tNdJ/25dQ/q5T61UBCxOSes7rnfWYP3SFVhLk12/+
         bi8zm2NQHsWURW+4ezyHoNcvXUwPV/RZEDEs6s7w/2aaoPKe73hcweWfvd4V4egyx0SO
         zWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781304729; x=1781909529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5YrYFwPVh4TWTkQlI+CIig/TdkWAayn3usWZ6HaRdIs=;
        b=HIirBYQrqvZ652OTwA0sHff2rif9I4ieHFAGio5vpwvB/EPjXIj/EtNsBZGCp0BSpF
         Qg0QD3DXjwPvvOv9Qj5vKiEQJfWm2bfaq9YdUNFh1DXUtE0fVDSiwpqmrgDKsJYeyjli
         FDv5Bx+o0K67ixfwAaZ2HMR5QpfVrtGkVUkfnzZwz3nKfwzuKKl66Tak/uVS37x+7RGq
         +xizN7sIB+xVyC1b4rk7Z4vSszWJ0jc5B/PBJLktLJJ4FcW960C2CjpbrOw8kr1m4ZoU
         o1k41stvJA46Csv2YNEU7PUhZYRVmuOeqgbiLmXL2Fl4gUFp3ZShNf6ZYN08+MNNadhY
         gt8w==
X-Forwarded-Encrypted: i=1; AFNElJ+7pvzDXf+zZ2w2NY2aXnkoOxRDwO4zOg6XauFhQmIMump2XKS0j3m7llpJIXUAUCBcHJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Ij2vL4IUJkJdfxaycfrrgaI189zTj/pAgRGibIm+OXH5Mesy
	FrJ2+P3lkujf+Epq9rJ82wYwkBIpDUIwvGjKGqe6mCVEgshCtG6JNjzVxHeoRaikTvrCkkTNuo7
	5awRFrk0qKy1LpnyEpgHfgw+mUCBoqvrTfjZyCzVb
X-Gm-Gg: Acq92OFvGoldVuj4IJyUE7pIwPc9KiCBIewp+bksO9e2B8XcWONmi+zAOGCrwyhAqF0
	D0Nk2U8d9V1EtXOT1LvTR87S0T4lcn7rJgmfUYWyLFzQX4Wr64bMIjGmWVQ5zsXJFAdNFrFpXVf
	S9l0oRMW99lqSm2EVTWvpCvcVp+OcQhLm9OBNdKEXItZKTA3IA0Dazua3cjwPYgU6y8EdVKXNyE
	sKA3Osy4iZo6qgE6I1c1H/iReJlWCbvuAs5ybsRRb4+4BA1FKhEBSGpTzTUsoXM1YXviRW1MJxu
	WrGj2yo=
X-Received: by 2002:aa7:d582:0:b0:68a:7046:e64 with SMTP id
 4fb4d7f45d1cf-693d1bb2d69mr6308a12.3.1781304728195; Fri, 12 Jun 2026 15:52:08
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com> <agPUfzbMzTU1ebii@intel.com>
 <agY6JuEJRhwpwlRL@google.com> <aga+jCVUW0d4GufQ@intel.com>
 <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
 <aiHY8cWZYZNb-DED@google.com> <CALMp9eQ17UaAje1DQ7v24U7iKujvnOknY4itQjSqOaKSn_FqBw@mail.gmail.com>
 <aiI6xge3Ev3PCpUV@intel.com> <CALMp9eTXLcDNAjjcsuo_nqjowk33yA58fjYZbz_Lqytn07RM-g@mail.gmail.com>
 <aiJlAhqnU0lwOAcG@intel.com>
In-Reply-To: <aiJlAhqnU0lwOAcG@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 12 Jun 2026 15:51:56 -0700
X-Gm-Features: AVVi8CeXnpGNQXHxV8iCW5PYYEaBZ_zgTbXaZR2fpH5wElkOoHQX6UstxB6HSOM
Message-ID: <CALMp9eQYc0AGjuVqCHL-GGe2cLOCnYZhTso=50HihdxTmNShWw@mail.gmail.com>
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

On Thu, Jun 4, 2026 at 10:56=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrote=
:
>
> On Thu, Jun 04, 2026 at 10:34:40PM -0700, Jim Mattson wrote:
...
> >With respect to EMR, you wrote previously, "A mitigation for this
> >erratum is for software to program the VMX preemption timer for values
> >below 2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0]."
> >
> >My question is whether the exponent, 25, is a fixed value for all
> >CPUs, regardless of their IA32_VMX_MISC[4:0]. It sounds like you are
> >saying that the exponent may depend on IA32_VMX_MISC[4:0].
>
> Let me double-check this with the internal team and get back to you.

Have you discovered anything?
