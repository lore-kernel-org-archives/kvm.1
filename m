Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923917A303
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782732; cv=none; b=mEefBUYu0VMUoxUfdmMAKTUiSQdl7KrjqqBiOL6f2lXJyYlM3Z2xlQTCBI89dEgbookQQDn5L3otmTmJbkLH7jj5q+J+yA/EndWENRO3GHrVM3OBtmEUKnMyRo2Rx4VjQl15mL7IXAD97c+jwbqdQIG9NfttmR1tmnmwPzCFuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782732; c=relaxed/simple;
	bh=6v8l7d6Bj+KBnucZNr8Q/6n3GftNycbVhDnxwUmgpxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=peiOCCE58r9i7jbJUoG75eHtsiTvRSRLkknpvdgXMPaAo57UedpnHC6Mgg5G3JM0DqhGdBFOprL9ZePo7liQShf0njumqX4wOcTnRihnOXH824bl33FkEkPx7g/p8tln98xa03dUvW9GEAaqa3VddVwBg2pSmANy7UrCa0KGGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0fL18Ka; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0fL18Ka"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c797e31a9b7so4283776a12.1
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776782731; x=1777387531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkC5SsQmyFi4P4ZC+Bva/sdA39QV4G+J9W/F9CJ/tjQ=;
        b=i0fL18KamOapoGpSbl+G5gvXXwKNVyWzFVo1iH/gmxQReVxWvjhCOD1OApdasVe4J+
         0xl2+/SFBIiovjWLfK5/b15J7fsJdM/kmTlSI88eU6Ahe86MeQmFjK/COjEA8Zl6z8JP
         Bjq+wKabb4rM1YmK/b2ugtfw46VK3ukRJnrRdNTFaAbYKTIi3837POqJoAkQ0MrUbkZe
         PsmQwXJ8geFb+9sH21/hEjO1kXaeCBDrNA8V5Pa5peDgxyY4BvZ5ciav2XCzkgif/yOC
         HGlsIBfub079PMdmRSfs16Rtv5BYsSJG5wc4JmurUJk3hxxoAs5jo7MJlq0npwdCNYZ8
         7Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776782731; x=1777387531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkC5SsQmyFi4P4ZC+Bva/sdA39QV4G+J9W/F9CJ/tjQ=;
        b=Cphek+rkkDN7bxfFM1h3YQR/yxOgw8Q9kwKzj1h7VXC8K7K+GMu7Um6QHDB1hJ2lxR
         bX86oi/RGVTgr4+E8mC/t22+Ilv/XK9EMpIeoOmt7zs6gNnCsYfZSwqY33HgU31rPmZT
         b82/4eO9DtZSQmt88ftraJS80uLZxasOb/H1Cm6MDyXJzdPY8Nx5uPpAcGgRA9LF7YYW
         NlCnXuYhVXxspZkYuOVHTsdbf/2pQiIvGkCgwrgIL5nV5Xj+BssLs0xdy5wvSDM+agFa
         3BRJkRzQZy8T0Ap7Mrq7XdQzfN+PnYJp/+Wm7bwy70tTVj8sa7shaAb4VCzWlfLIqr0Q
         R43g==
X-Forwarded-Encrypted: i=1; AFNElJ9qqGlZZAvfYxI5G2j9Hatit4oDAb2DaJ5YCOxHT7S+vXFglgiGxzIH9k9qhAsqDZBwLMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRars1W1KHpVgWsqWv1YlM3tqdD0KWbHJ+Jn6JMZ0GneX+ELv
	9Jst1jBfH9Jf0t8VZqaKzvJdHXB2GVsY5KRwP/0QYXKyuqEuss56CUMsPgFQfkQnvFJk5+704bZ
	xB+UPbA==
X-Received: from pfbho22.prod.google.com ([2002:a05:6a00:8816:b0:82f:61ed:8b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:408e:b0:827:2a07:231d
 with SMTP id d2e1a72fcca58-82f8c839c08mr19494150b3a.17.1776782730512; Tue, 21
 Apr 2026 07:45:30 -0700 (PDT)
Date: Tue, 21 Apr 2026 07:45:29 -0700
In-Reply-To: <IA0PR02MB9462F33B049604001F2469D68B592@IA0PR02MB9462.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
 <DS0PR02MB9321941EFE9070089B6E1AC38B4BA@DS0PR02MB9321.namprd02.prod.outlook.com>
 <IA0PR02MB9462F33B049604001F2469D68B592@IA0PR02MB9462.namprd02.prod.outlook.com>
Message-ID: <aeeNiQf6NMJk9zKd@google.com>
Subject: Re: [PATCH] KVM: optionally post write on ioeventfd write
From: Sean Christopherson <seanjc@google.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Levon <john.levon@nutanix.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 10, 2026, Thanos Makatos wrote:
> Hi Paolo, Sean,
> 
> Following up on this, please let me know whether this is something I
> should revise/resend.

No action needed on your end.  More discussion is needed to make sure this is
uAPI that we want to support long term, but we're not waiting on you for anything.
