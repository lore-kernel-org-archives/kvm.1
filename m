Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1523C3BF1
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082825; cv=none; b=OM1elDv4j7YzrhKoaqmIATHa+68IvxEC7q59lKXxPNCuWl3HrMsd6xHtzmXyGCDgejESJdCNxBdgM2XZ/i/uMF1wTGSqP+E/4Z9W+6Ir9ZPL499pVbz5j4klaLn5W2OmXZVR6hmx7j7GI7QJbRpz5BKTP0AxNskuwB0sir+byg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082825; c=relaxed/simple;
	bh=sg+50Q8sxRR1Aj/0H7R8h6PT06l8kVwGZNKTmLDU/uw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WFPdeLnkGRfK0COAN/1Nnv48TcDFEX67AhBhFcvmmnIP0VhJ5xiGU2XieExxJDehvb/SW9mSs6L/ivjLd9CfDeyOfh5yvYiMlNT5qmv0i9Ee1p99Sk1eE3ZyrrDIqnDSCOsYHnIVe7r4OTkygNYGpnQDXpfudwah2Y975GAJS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZX1gd6er; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n5Z0JBdh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZX1gd6er";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n5Z0JBdh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776082823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sg+50Q8sxRR1Aj/0H7R8h6PT06l8kVwGZNKTmLDU/uw=;
	b=ZX1gd6erwB6IYQGC06mUv1cNHVOMBmb3ia4N3qMl1UGcX+oiTXgvzAF43PQbp9f0yTy3x5
	JmnLhDqCFjmoDdjpklyRp23CSemo/iLRIcSCS1N2l4qUs+N+6p1cJ0JGuWhnpBygnw6VC6
	K6tpK6ImvjkIWwa347UrThyzB4purzo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-OP6-nr3lN0SwguFLHoOSeA-1; Mon, 13 Apr 2026 08:20:21 -0400
X-MC-Unique: OP6-nr3lN0SwguFLHoOSeA-1
X-Mimecast-MFC-AGG-ID: OP6-nr3lN0SwguFLHoOSeA_1776082820
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3595485abbbso4296434a91.2
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776082820; x=1776687620; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg+50Q8sxRR1Aj/0H7R8h6PT06l8kVwGZNKTmLDU/uw=;
        b=n5Z0JBdhJtdIaiW3yPy4PM/9rnq7pyS+fjYQA9eUylmQG5Fl94lHFiH1e7mH4NfsTb
         jRFrvjTF2t2GGxskLRfpV9WmPntwyn3HAMw3d1i3YeORNMLS+EoHbeYvYbjMv3PzzAqE
         z5toY1e8FWxOcLoU+vxXamHRSGCHFgD30rBduqm/mBUQGeCp0AW0F4RfpXEUVcR3N1hU
         C1AfP/byruXw+9IJBv9bKRIqa+lYcT/IoHKTrlcfYun7y0QbS1pdja6yu0FF/IS65kYJ
         /+lq3snLU2l8rSIUV65vJQfulmIs0Z499csZqqUjxXuwRb5lp+gG87TiaM41CBDrPng5
         KEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776082820; x=1776687620;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sg+50Q8sxRR1Aj/0H7R8h6PT06l8kVwGZNKTmLDU/uw=;
        b=Dd5SHJVt8bvO/ihQFOKaKiUloHn3ssmDzT264xoGIcsaS5Do9tqkNtBcCYBZUrHu9w
         6Z4XcoHKI1nF3363wACQwxD0HOWVMkoS9tmp1iuDzwSuhq2eq4Tytyq3LbQW7PR0AyXO
         9glNNhqu+tInxs1X8Izw/T6VJxAJObKR2e4TZZ//P5cxu3XTKad0AuVWfIWrlrLon0PH
         gH3Bey4hNwG5qS4dmOkjwcuWUtZXDRxGmrv7Fn2XeJFoTqIQkuvP5529KKZmNmtmUThv
         c/IC7Pc7sY5xR+WQf+dDNHG2gUt9W9xP4jpk4ZrrtyeZ08Gm04vutwncokTexv4lcrBi
         KzRg==
X-Forwarded-Encrypted: i=1; AFNElJ/IfL3sAMJ+rEPyrTI/Mf72QMJrOzV9Md/cnIRva8w0HA/AISx3LDZN8oKcYdtKXT/UT5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYsA0xH7jyNF9hLZzgcApnO/C9oRP3fXgZn4x9TYdngr6PPJnd
	iJAUDsYXL/ApGtNznx3sIQzmJ8z2fmV0VF4fJ+j2khGPid6pMkfy9ME37lqtDfIWMJnIJDJRf2b
	xuyLn27R/prTnRnylZ4A5UOPH1OEASVof2csOZr28GGuNE7UHy8v2tw==
X-Gm-Gg: AeBDievP4pqxS/l6kc1crhIGcZRag3QyssHCKZQ5ChLnr7hutooxkoklu56cvWKc2CZ
	AG0+I4SSmAGyPOiovVskx7XdAVG1HNGd4ONOplC3eq5AmPnGZoBK7dEVL/d7p/1g7N0PPsrJbcg
	yCNvzu1zDMTY+cslLzPtY4edqQdOmqG1mXvwqS0sic94CU8o6QFXp/icDcb/gulfyxovVk6IRsu
	MZ9CILDm7+DTmEeE7Sezly5U2bisu24mXjhDH3H2L7T8TmDnW5qVxlv0FWeUPmrckfJUtTne91D
	2X8f5hbl5h2IFIUgCUyHbRtrCIwrhEq3kEm7FrA0/DDR4KxHF8BBizGGOJLPXD4Y1Ma1zoVcSni
	arnLm5OcVqTxosBZG8Rgxysew3jb2agPki5q8s36kkHPl99UqxpYTZfd52akrW7IRa0d4fgoXUf
	M=
X-Received: by 2002:a05:6a20:748b:b0:38e:9220:ebbe with SMTP id adf61e73a8af0-39fe3d616a7mr14231528637.23.1776082820024;
        Mon, 13 Apr 2026 05:20:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:748b:b0:38e:9220:ebbe with SMTP id adf61e73a8af0-39fe3d616a7mr14231494637.23.1776082819551;
        Mon, 13 Apr 2026 05:20:19 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7922de0626sm10683181a12.13.2026.04.13.05.20.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 05:20:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAFEAcA8CcD+8Hn2++X5FnyYcsDLV4J=tFg5BAd_sRJmCw+nVkg@mail.gmail.com>
Date: Mon, 13 Apr 2026 17:50:04 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1974E499-C3D2-4A3C-A5B9-89961751F23E@redhat.com>
References: <20260413090010.60339-1-anisinha@redhat.com>
 <CAFEAcA8CcD+8Hn2++X5FnyYcsDLV4J=tFg5BAd_sRJmCw+nVkg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)



> On 13 Apr 2026, at 5:40=E2=80=AFPM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Mon, 13 Apr 2026 at 10:01, Ani Sinha <anisinha@redhat.com> wrote:
>>=20
>> During refactoring of kvm_irqchip_create(), the refactored code was =
returning
>> early from do_kvm_irqchip_create() function if the required =
capabilities were
>> not present in KVM. This was not translating to an early return from
>> kvm_irqchip_create() as was the case before refactoring. This is =
because,
>> do_kvm_irqchip_create() did not have a means to notify the caller of =
the lack
>> of kvm capabilities. Fix this by making do_notify_irqchip_create() =
return
>> EOPNOTSUPP error when required capabilities are absent and then the =
caller
>> can check the return code and return early.
>=20
> As a fix intended for 11.0 at this point in the release cycle,
> it would be helpful if the commit message stated what the
> user-visible consqeuences of this bug are.

Ok I would appreciate if you can add this line in the commit log before =
putting it in CI:

=E2=80=9CDue to this regression, all KVM guests on PPC 64 hang =
immediately during startup"

Or if you prefer, I can spin up a new version with the updated commit =
message.

> That helps in
> identifying whether this really does need to go into 11.0
> (i.e. whether it is release-critical).
>=20
>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM =
file descriptor change")
>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> as the minimal fix for the logic-bug introduced by 98884e0cc1.
>=20
> thanks
> -- PMM
>=20

