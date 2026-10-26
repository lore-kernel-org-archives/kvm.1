Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036011;
	b=YK+uvPuM/obzBc+bwtFnprCEm5mgC1KkNWfp/YjiW4+4X1tWta6c/uLKN6MBPr213i7Y
	 /qqmwj9cLdb2IU8R0cYG76UzjIKmirU8gcyiB00vYxYR9qVqWb3yvNnMuf5VjYK9Y07FN
	 MCQ+1zjDjf4yBQ7g4ndOy2HWhq5pJyhZJVElw+gyOJ4SYbumedCnOZ+qJ0coosZuZ7Uo8
	 AaKjox+aHRR4JRvbg0zVAjYI50EgMAFaFrHYlL2HpCAcrrO1VyHSSlzZe1KPNJ6zJNPWb
	 PEbRyRJDH9JX9MYTs2yvVdmF7GVzimYftAm3IBG5b+JjWX9Pjfz2DCICepfsy8Jm7jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036011;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=BrEL1yZYpIcLAzHAsc2Z+gooj+CaoTSi8SiGe8AGnNY=;
	b=wQfnRYx2XgftRRELsiXHAQJ5M2hCaknq1cmB/RxOi4NfAkDQgiMZaXX3NuQfyXyuC0vE
	 UN4plSVJxkfXCWGQCg6Cp2eJt8agNWfy9ODq6sYzlAGSCh3DxzaUW/5MroFxgkwVhL6U7
	 cbecI9Ked/4vP60yvy81QpLcRq6VJ2SeeO0x6wI4qWVDgURJdUzLmxjXQ2YXupndJ5N5U
	 /msA804k/hWgTxb/Fw7A+NS7MRqCOL8cK5D6fJ5B4VSnS/tZ5shdWkpaS8pEla2+ht8yN
	 hmrLUIMtCvFnrB5UiFuwRdRwvBRRz02p+2XCjo91EwS61OnkPl8nlCF8wVECt0VS2gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=LPPQnzvK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dTb7AdHY;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693C606A325
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 17:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8693C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=LPPQnzvK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dTb7AdHY
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id B7B0BEC0AA5
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 13:33:24 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 26 Oct 2026 13:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793035996;
	 x=1793122396; bh=BrEL1yZYpIcLAzHAsc2Z+gooj+CaoTSi8SiGe8AGnNY=; b=
	LPPQnzvK+SbfoIih53v8f7y30iomOt2k8Ona9dhrLqDJ7QMDrjGz+ypGdQrgxN+5
	32YhuZaj/uxVHmJhzOBU960f7XjNgdyd/WbJJgrFzA00QjauB2IiIWKbBj/zsweW
	stVf9VlhggCahTm2QGgocMae//6HG+aY2IdNbi/RjtSPpbTeYosqCQvt33pnsvGw
	y1elcktCk4jYoMduDvgIPcJ+Enbu59S9KYeOv0Ec7GGcIin+XctzrDhscdQNTIHt
	fm+QNESusNfEH8oM3vYQxnhNT+zfythfJ6sQZikB1Pmsp08OpSduMB/BYd6Q6mzj
	s1cvR/y0H4AwdM2D0k5rPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793035996; x=
	1793122396; bh=BrEL1yZYpIcLAzHAsc2Z+gooj+CaoTSi8SiGe8AGnNY=; b=d
	Tb7AdHYA9xuH7bpYYJmXI5xjExbHTJ5GYwjlNkIlSoXpMWGJgJ0NUlnoNxigfD59
	tJjOPUbiek97zMjnWIj6xj6vdkvbmbI6+4kgPEFH8edcO8XW04HKocZY8+hYH/4R
	DvLRzhqxnMeN10pstFp6Es0whRP1GaMpM+2RVeQdcLike2HUdlK3f1Y+gaPjIefh
	65i0nfDnOo/jGss2KIOPU7aBCnyOuVqLUqKJQRiwRIGmcOuj+iFmmLv6zvMSpFTB
	qB7YV8KAP0x4RS/1uGCB4eZVcc1OwmdhMdvBwtzVUd3CKh26mlyfYcLqJqxDPo2s
	FKF7S1d4dUbvdl/YCoIBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793035996; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mnHI7imYN2swBXfEww89Bf+NWSWwJPDbwFqKtr7bwm5Uv8J
	mdVEmJ1CetpqzfYC0OOEd47OIzvGwzK1ZjQxEgnMli+PQGTIVjjU8ZcWY2//dZhv
	2HH4ePYL26uU9v5U3wBbjpMQUnE7Pc6nkLJry/XpcQo8knWNl9VsPjJvkpsFYzPL
	lQ1p4rORStKIsdBlN7+KS0CI5fBtRjTYdSPLAo1xJ5G3q/vSjzqJmFDtH3X6d9bd
	Twe5nyp1W1LfAIuAL446mIKXDH5aQevHtsmmk/Rg3Hztwk4fo0UPmDa5UaVmsBn3
	y7NjACDZvUkA0XKSQCzFTLdVLG/V11RgrQUgMPw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nuP/XYnK8k++am6mOyTBSaP16sX+nffcxYhrlvU22Is=:+RgG//+JJS0R3Sii2WKnGvIJg9YfR5JsuiisEYNP0G8=;
X-ME-Sender: <xms:1o7fapdbi5D_OSjkA78u6NEKwFbC2_ijHXP41WJAsWWbkuQHMAbyiw>
    <xme:1o7faiB9YvyA5FcET4mI8qaK55gKkplosjXaANuXxL2IN4lvUxiPhiYfmyqtxMghg
    xkb1AZ1CP0rviSmq2ZAzma8IDoRrYXSfFwhBjJkIR4LrLOF0ribIg>
X-ME-Proxy-Cause: dmFkZTEUuuijA2lITnyDOlv6F4rCoz9elyg7FAVVW22fRBFyD8X1akgZLQbCt8FQNtWoev
    UWBdZ9wARR4AXT3sACjCuGKxrD1Dn3tymdVnvkVKwRI+R7DW7khN2LpJOLJCH9TI74vsqH
    Br96OM20HT0yHdvdmJK97Uh+QWVlFRmW/RLRb7xTAuyffzSv4bIOWUxDh+Hq51dzxhMBxK
    7KfJNAiEZvP0UhpvlIz6XOcGyC0BcL0381v2C7Y7Q0Qzyj1ZA2XISjR4l6gYVKoN7B47/O
    ayjgStE8UV8JErOO9ZuPLGgL0Q1+rFUu5FUq/3IcExo4q6qv8wpljRRDrEtlruxYb3iiE5
    xDRgWsbLVAflTIBSJC5EohgVRIqHtQSO1FhY4SqL51YbXExkfXSOPbBa234flL3RRvbRJY
    8FabQvqD9p6/PiP2Jpli3pwS40sMGJ2uRuUlpXW1JOh5EIGFRq7T1jVOYbfRsTJQdlJcao
    BBvx9qOCNLCDSwym/RJei2TRd5KZnjXb0CzQNiSU5hUZSsHHeqEHIBoNaOpN//p4Ug04cC
    89IoLl9S4c4zuqFp/rcdaLsmVB0MC0Hs3tdTJI5QtISxRMpn6KrBMxnwg3kkx2W9IgehMR
    sYQeP4E4X1druqWKUVq0qpcLQIZ3UKEW2/Se8O0UNSfBLXj0nunedPKE7aKQ
X-ME-Proxy: <xmx:2Y7fakVoIDc1LbkN99p_BDg4zeB_Ha6lOaLhScOE-raa34zFZvDygg>
    <xmx:2Y7fajQ8vK6EXnvGqwYtD1PSuA58bKmoka0dWgqrsLxg1qcJeDHcIQ>
    <xmx:2Y7favAM7CijC3KkP8SfDD2aKBS_sWPKXsM5PJSibC5ax74ehiqgIg>
    <xmx:2Y7fauS9iSq221n_QOxNwlDa_H83M1xDY9qMeioKEJwSD7T4Ti9akg>
    <xmx:3I7famXPASOO8X7RSGzpLjSsZ2SEmpe19AkfBFYuj8BHEeX2zmP4Zetc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 613AC32A0099; Mon, 26 Oct 2026 13:33:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A5YN6CdS_DiJ
Date: Mon, 26 Oct 2026 18:32:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Fuad Tabba" <fuad.tabba@linux.dev>, "Marc Zyngier" <maz@kernel.org>,
 "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Joey Gouly" <joey.gouly@arm.com>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Zenghui Yu" <yuzenghui@huawei.com>, "Steffen Eiden" <seiden@linux.ibm.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Yicong Yang" <yangyicong@hisilicon.com>,
 "Zhou Wang" <wangzhou1@hisilicon.com>, "Fuad Tabba" <tabba@google.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <4066f726-310c-4168-bc06-1502740703db@app.fastmail.com>
In-Reply-To: <20261025075138.2919734-4-fuad.tabba@linux.dev>
References: <20261025075138.2919734-1-fuad.tabba@linux.dev>
 <20261025075138.2919734-4-fuad.tabba@linux.dev>
Subject: Re: [PATCH v2 3/5] KVM: arm64: Add context-switch of ACCDATA_EL1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Oct 25, 2026, at 08:51, Fuad Tabba wrote:
>  	return kvm_has_sctlr2(kern_hyp_va(vcpu->kvm));
>  }
> 
> +static inline bool ctxt_has_accdata(struct kvm_cpu_context *ctxt)
> +{
> +	struct kvm_vcpu *vcpu;
> +
> +	/* The host never uses ACCDATA_EL1 */
> +	if (!cpus_have_final_cap(ARM64_HAS_LS64_ACCDATA) || 
> !ctxt_is_guest(ctxt))
> +		return false;

Maybe add a wrapper for this as we have for other features?

In my patch I've converted the check to use this one now:

--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -909,6 +909,11 @@ static inline bool system_supports_bbml3(void)
        return alternative_has_cap_unlikely(ARM64_HAS_BBML3);
 }
 
+static inline bool system_supports_ls64_accdata(void)
+{
+       return cpus_have_final_cap(ARM64_HAS_LS64_ACCDATA);
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);

which makes sense to add in your patch first.

I think we'll also want a HWCAP3_LS64_ACCDATA exported to
userspace, but we can keep that separate.

       Arnd
