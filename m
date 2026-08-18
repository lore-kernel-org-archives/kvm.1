Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318339B969
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051552; cv=pass; b=LC89/ybFE4bifNFvFPjVBP0XgkdmyQdT6r8qmWu1f515NNR1s9kzynqLQNOhlPzLQvrst+lokX1i5MJOiouE6CGHH+uzgxxnS6qqV8q6CtfuIV0+zPa/lD5+A3d8f8TJJJbZ/NguughbQeyTgSQ3DnaVOGze71nAAHKxEWCsFvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051552; c=relaxed/simple;
	bh=pjGyd28tgFr6I3kKT/1PghjrVtzMwTs6sWpJtRvgfV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqe5F1xhyS/acEDXVxbudXtAdtEzFQKoecWeENWEZ21aPCoIDmSwGnEBDHveRVcgcyJotKznMTtjiXY6EqlNhJq4pVAp4Slk0Ka5uD54AEMo4ERG0CWvL/kcneWx/u23C+QI1PsYYPozX9Y/fMVTnq3YTjNj0tEobnORSj3vDCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPu7qsCY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=le2xfoWB; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPu7qsCY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="le2xfoWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjOYyVQjkyKYRzWlNzvKguN/v4vYVgXA8EJUgP+Bibs=;
	b=BPu7qsCYqKtJYerCnoIHkGIGSfaRPzuyj/ySoNxB6xpZDleFBANRiugNAaDjeFJOcwpr8z
	TMvhe3WGq3CtHB1wJCIRXNQzFewHtnKz36Bs67BER0tr7o7PLAc0wQXPbgwL4Cy7AakPSk
	xBHdDcnUS72HhzfhOloNynnINCoOZXM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-GeZF9h6DM6qP6a6PebI9YQ-1; Tue, 18 Aug 2026 07:12:28 -0400
X-MC-Unique: GeZF9h6DM6qP6a6PebI9YQ-1
X-Mimecast-MFC-AGG-ID: GeZF9h6DM6qP6a6PebI9YQ_1787051547
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954a93c565so24037605e9.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787051547; cv=none;
        d=google.com; s=arc-20260327;
        b=Kb4Ua/lSK1pURGIUPmfkB5l8l8N3SbuQoEChq3R27UoTNQ3XAzH7ryd26GzUcbZXkd
         brF+3/RCFbMcoFOATsVoflYVEL1Z7Lli7UKX/PJDmlqSa6JGCddtptj+DaL4ddaIrKta
         hLc79fuG0B5rxvrhj0Rx6FibGOrSaDN9lPGD6742dbv+OEQoznEZGqK2ASNbLL0/rIEN
         ubSsPwVxbwATIS8zjI1CEWEm5AbyCUlln9w8kaG6rCootnpUyD63FTgRPZtCzu2vSTry
         0fsK1KaZastQUAqDr2T/9/x7Ky2/VJmIzWfdJZ4XQaUdW+YFKG+pP11FKrG+YBV/nT4n
         H6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zjOYyVQjkyKYRzWlNzvKguN/v4vYVgXA8EJUgP+Bibs=;
        fh=9VH4wHc8dyykkWXw29vL2FxXzJhx0at45A6w7j/4PdU=;
        b=ZlXHZxEWW7ONn6yyjeNj1z1juj8vVxHTEhosMnPkzkYPKGnjaOBGrPOKCTsm8rphMX
         3uB+xaSdQPBHfXW4y02PDIX3I7Go40peXkkFg86uvfdnhQJmbjEO3wJL7KEgWW6J3fAh
         0DhaZTslPGHlMNXXH6e65Rdef4gyFkOXqkTop82X71sdz/rB6DLarmC3llIiAtkV8dxy
         Hdwsg0FNMH+oCvXOfdJ5BZ4uoSDdPREvuzRhTTbgXM0hO/s0EhbPoeeOvI/iBE0kZG8q
         ZDKXeN2oPeQ7G3Umk+7Ctu+jbydWrKIyRmmSqMm7dkgwni/8UdBweOrWxduJcuHbjzTb
         9KVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787051547; x=1787656347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zjOYyVQjkyKYRzWlNzvKguN/v4vYVgXA8EJUgP+Bibs=;
        b=le2xfoWB8GaM7GS/sdqSRux0P4Bg7AhN/wzVoyHJ/asV38Po5CZ/it7DsBLeOCL7KE
         +MxpcwYFcUMcqM8FaHmVpcZ9VCt4xsZcXdZ/YoB+rNCTVi6Yc7xbhuS/pS+XVITnayfu
         Qgr5dCsJ9s5JTZeLsToAh6xF23EQysPpsRxmL+CnNUXJPYfQevm/hXGF6ReEAwREoa46
         3jOlnnXX8N84duAP4+nqcWTGWPypC5ZT7m5C05yOiVlsUg0CfhgTWuRPt5Roq9BA+z8/
         hzpll1UxpL1vziNoNRQ+cPvugKk8Yt/h/6H9J6c0AcKpXu15ravQGQubughHJIUwrBsS
         h9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051547; x=1787656347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjOYyVQjkyKYRzWlNzvKguN/v4vYVgXA8EJUgP+Bibs=;
        b=gZnpwV38QH3arF06AFswYD+FHapm/Cos68zuQGbtXqc/xgqO2VdpdKgnomRkG2clEb
         To8RkoaA1tX0R8RW6DlMYEcaVVyZGov7OBwJnaHj0rteAjuDsZ+7ukfI79vnK5Qtahxr
         dqJmMu/EpqIdNxe2PVP3F6sAqLzsMGQKitJF5VeY9Su9/Pbr+UePucJn7UqwrsAJi/tw
         fhMqbnq021vH/zbltBQAQmUZ7yqb7FH0LTr5Vli6VIdhWwiQQ104tVW2Rs8JKlSpPUdd
         bVOcgZYZ1iYCGOGtMY+eA7Ucq6MkX1tnlzNUH6TcZOEj7DZZQFAS0oDAN4ALvIEXQuUu
         eGtw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4iBFDjCQPEfdrn0JmbgSVcED8IQA9v/UlwxwJG4+j2Gzi2lyrRGdSe09CuAVkWBLn0dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF5QEhjA+D+HgAw0ESdGmUauzKavhOrW7k9vmrgfl3ELX+Y6wu
	GfxgTBPyCl9AQPSEnWmVGtrUnji2qgheROi5sFuumP5vHNE3jQs+hrvZUgJrY8pFJ5XhrBI3BeL
	MFaF+s1hhcVsAHANuBSBGLhzG9CRp1CZkTcJjfkp6OGZsIfhpnkoqep+LxnkcbZnfr+cBf3X1SP
	uFhxNaKFcrzJx9pqDKhpD4HJYxUdc90DKNYMTu
X-Gm-Gg: AR+sD10SESJ7oT5LaGRNsoPLgAP465t25myOalxu0G2KZxCxZCzG6r9oMNkx2vmCln7
	kJySqE8YydfRMHpydd1VWNeotc0wiRRH5x5xRYT8t/tBY6pEasivSd/xe/go4lyGdj92XtIUOXE
	gGSFT0XCqsgebDe0FPqqO8UrxfUB499hDed5IePausrNBH5fu0y40g054B7ChawgWXTLwKjyD8E
	LOgROufSYJApmOudiTDycXC2opjNOVjRsv6lpqwqMRc9SfsPf8cqdEjHyw=
X-Received: by 2002:a05:600c:3f06:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-49987961c32mr536824895e9.9.1787051547142;
        Tue, 18 Aug 2026 04:12:27 -0700 (PDT)
X-Received: by 2002:a05:600c:3f06:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-49987961c32mr536824235e9.9.1787051546760; Tue, 18 Aug 2026
 04:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813120829.823203-1-chenhuacai@loongson.cn>
In-Reply-To: <20260813120829.823203-1-chenhuacai@loongson.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 13:12:14 +0200
X-Gm-Features: AcwNN1WJL9DCYlzOykUxmNciccKYc8fmPASDT53jdKrBVMbmWn0FeKifCQ_Yxrs
Message-ID: <CABgObfYdTy+EPt4JSatYCKUnDwmvqNF-JYWH3rJeqJz4gK3NgA@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch KVM changes for v7.3
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:11=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a=
58:
>
>   Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git tags/loongarch-kvm-7.3
>
> for you to fetch changes up to c5959723aaae06aa617253528e6b228b3c858215:
>
>   KVM: LoongArch: selftests: Add FPU/LSX/LASX test cases (2026-08-10 12:2=
1:58 +0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> LoongArch KVM changes for v7.3
>
> 1. Advertise already-supported capabilities.
> 2. Some bug fixes about timer and MMIO.
> 3. Some hardening about interrupt injection.
> 4. Replace kvm_err() with kvm_pr_unimpl().
> 5. Add FPU/LSX/LASX test cases for selftests.
>
> ----------------------------------------------------------------
> Bibo Mao (8):
>       LoongArch: KVM: Set vcpu->cpu before IN_GUEST_MODE is set
>       LoongArch: KVM: Set default MAILBOX access size with 8
>       LoongArch: KVM: Return directly when IPI address is not aligned
>       LoongArch: KVM: Fix uninitialized stack variable issue with dmsintc
>       LoongArch: KVM: Use internal API to deliver interrupt in kernel mod=
e
>       LoongArch: KVM: Replace kvm_err() with kvm_pr_unimpl()
>       KVM: LoongArch: selftests: Enable LSX/LASX by auto detection
>       KVM: LoongArch: selftests: Add FPU/LSX/LASX test cases
>
> Tao Cui (3):
>       LoongArch: KVM: Advertise already-supported capabilities
>       LoongArch: KVM: Reload one-shot TVAL on migration destination
>       LoongArch: KVM: Prevent division by zero in periodic timer restore
>
> Zeng Chi (1):
>       LoongArch: KVM: Fix PC double advance in kernel MMIO read fast path
>
>  arch/loongarch/kvm/exit.c                          |  19 ++-
>  arch/loongarch/kvm/intc/dmsintc.c                  |  18 +--
>  arch/loongarch/kvm/intc/eiointc.c                  |  32 ++---
>  arch/loongarch/kvm/intc/ipi.c                      |  77 ++++++------
>  arch/loongarch/kvm/intc/pch_pic.c                  |  12 +-
>  arch/loongarch/kvm/timer.c                         |  14 +++
>  arch/loongarch/kvm/vcpu.c                          |   7 +-
>  arch/loongarch/kvm/vm.c                            |   4 +
>  tools/testing/selftests/kvm/Makefile.kvm           |   3 +-
>  .../selftests/kvm/include/loongarch/processor.h    |  18 +++
>  .../selftests/kvm/lib/loongarch/processor.c        |  11 +-
>  tools/testing/selftests/kvm/loongarch/fpu_test.c   | 137 +++++++++++++++=
++++++
>  12 files changed, 269 insertions(+), 83 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/loongarch/fpu_test.c
>

