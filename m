Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2723E315E
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800276; cv=none; b=sK+7MyZ+Y3ASSaVQC/OpIXw4HkD6IPR8DZNt/2p7tlFIdeBs0V/9k6ZPXpr1TVUhUQuHvQkwgVqztObITxvUpMAr8awNF782tKBYUOvFcfGxtUN4QjTeizH1ZJILeAtutkdpqF+yFRsZ82xvk9Ur48PgCM8c0EoCUrXi3sWnoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800276; c=relaxed/simple;
	bh=rtzEqKJ3lSJLlG6ekherfDyGEniFcemmWjlnIRujPjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1spOkZToGH2g2HE1XAjsU0AVWyh/beBfo/jE2msrRH5E60c0EJYpHmQoCZZ24DinJMUXqz3vgZ20waR0LM6EfgJnYQjmlPZCBR7bDrQCRbGft552ZsCNPF4Gemg6RcSDHfhoCSD9boAX6+aHOyvHvqrWm/GwrziBZUvr/DQ0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvjVcB0z; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvjVcB0z"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-139e498e428so151777c88.1
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 23:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782800274; x=1783405074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cJsH3I+i++RnxS0RIEDx7KJuxyJs96diVU6IFO/NzsQ=;
        b=qvjVcB0zNV2gVuYWiLsLScenPJiNkgtMNLoyLnXpp7wL4h1PxQ90cQCev+5OlsPPv0
         Et5Zlv4Rk92EFgVPrdiT6Wgg8iOwVTfAol0zuxn4vciOGtIBkDJDcOl7NvInbU6atEq/
         5x2wRtxFwiaVM8IkTP7JIgi4g0ut5y1bAblPTyvWDuXbNbbLsLj6kQyhT8WDDXbjMHD7
         EvWGjBjsolTYj1PqpmuLyjEAm1eLVdxXp6ZLiiLj4L+o5tTBcZNHM1y+K4uZaQSWf9mJ
         E4FhG4tYT0YSy/jU+xwTSKhTDnM6bqwd6w5sCn5nRJhgR45P1WCrDQf1mXAPCrb0K2gw
         GBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782800274; x=1783405074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJsH3I+i++RnxS0RIEDx7KJuxyJs96diVU6IFO/NzsQ=;
        b=Btb+qEs8yNUErzp2p+j8zTvwnBURjgcpN5KmjE9wtg7booSzrRL4017b/Oc5gNDekG
         CcLb2eim1CLLoK13wSal9pf9TAjdCOo3mifVF3a2SI4Ik838IHNO32K+Y1vGF4mbku6Y
         sS051DsFPuPivmOo2DAZLrcYksHRJOR3K1iuSzGyijC9izscpWZ5QgF9uo2qTBH7Zy3H
         px7UuLTODCUYAIK3iUYh8Oqyj3LKlRzL2iOAycZ54h2g95G5lFTt01WVPEU+A1m+aDIo
         mz8EUfnDqR3M3HqHlp9VLhidYYqz8emUCQjCzHnfzrdhseMovg5NuVkAdGuxp4KrpUbV
         0FGw==
X-Forwarded-Encrypted: i=1; AFNElJ/jjq4OIGnodtfh8Qz1UbhwxSipVmzYfkcpW6rJCyat4Wyq1+XlNYVbABUxUlexHhC+fPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsH/Azxp669EYV9Y4j4DGosJMBYDUbN9LtTo+TAZoH00qf3yAH
	nCG0vLwsTeo572F/EeblQD3QQbhiaC4TdKzV3wj3QJE2qUztuBtLnznd
X-Gm-Gg: AfdE7cnSsMmKxLmw1uNOEP3/IRP/uKi04Pohk2vaSVHx/xi7N4VKukuxHZGB8EbR7NX
	2rexu8gPR3z+NyfgTDImS5wZ5C9IBqF2kQXVw2U/jBbbNjkRlxt7t2rAns0mFagMN9OlxBCliU7
	teJwJyxZFV3qfLm3eJk9FVM0ULSpWxMLrDfRR+DeTiu17PYzVux7J9fM2FuD9y3D3kkWJ51k3j8
	DIgQw6GgzWwN9KCvO/vRQ3aqKPSU4nD8+1Ccwxuy5PjIdwM10JDSymLmJoJ6S0fKXcu7LScjT/O
	d64PRMV2GOicFktDD+nSokWx7x7fVCD/4y+zGVaQdDNVOu1SqkjzXeMBxZYzKDuY+8YHvlBRz+K
	g6WLDypE0+Q7tylURiGq2Zrb6WxYq83NYz/Lu9xosTI5/a55iOBr9xc53Ynx3KN9Udm5t9X9Izn
	0wslls4Tcuqxe/sQuYQPT7MRZk76bUzec/
X-Received: by 2002:a05:7022:206:b0:139:fe25:a53 with SMTP id a92af1059eb24-13b2e32bb8fmr435157c88.21.1782800273787;
        Mon, 29 Jun 2026 23:17:53 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2abbba82sm4607658c88.14.2026.06.29.23.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:17:53 -0700 (PDT)
Date: Mon, 29 Jun 2026 23:17:50 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Jesse T <mr.bossman075@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Conor Dooley <conor@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 08/16] riscv: kvm: Use generated instruction headers
 for csr code
Message-ID: <akNfjsbVVcPGNg5a@blinky>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-8-7f0810ee2274@gmail.com>
 <CAJFTR8T33Yw-wqPFVLe8it2cWjXCz_xPpRCRmoVMQyn7_=UBqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFTR8T33Yw-wqPFVLe8it2cWjXCz_xPpRCRmoVMQyn7_=UBqw@mail.gmail.com>

On Mon, Jun 29, 2026 at 04:25:53PM -0400, Jesse T wrote:
> On Mon, Jun 22, 2026 at 1:08 AM Charlie Jenkins via B4 Relay
> <devnull+thecharlesjenkins.gmail.com@kernel.org> wrote:
> >
> > From: Charlie Jenkins <thecharlesjenkins@gmail.com>
> >
> > Migrate the csr parsing code to use the generated instruction headers
> > instead of the hand-written instruction composition functions.
> >
> > Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> >
> > ---
> >
> > This is a simple transformation that I have again validated through
> > brute force.
> > ---
> >  arch/riscv/kvm/vcpu_insn.c | 47 +++++++++++++++++++++++-----------------------
> >  1 file changed, 24 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> > index f09f9251d1f0..8ccf6ec722f0 100644
> > --- a/arch/riscv/kvm/vcpu_insn.c
> > +++ b/arch/riscv/kvm/vcpu_insn.c
> > @@ -146,43 +146,44 @@ int kvm_riscv_vcpu_csr_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >
> >  static int csr_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
> >  {
> > +       #define GET_REG(_rd) (*((unsigned long *)(&vcpu->arch.guest_context) + _rd))
> > +
> 
> IMO it would be better to make this a static inline function, otherwise.

Yeah that's fair, I'll make that change!

> 
> Reviewed-by: Jesse Taube <jtaubepe@redhat.com>
> 
> >         int i, rc = KVM_INSN_ILLEGAL_TRAP;
> > -       unsigned int csr_num = insn >> SH_RS2;
> > -       unsigned int rs1_num = (insn >> SH_RS1) & MASK_RX;
> > -       ulong rs1_val = GET_RS1(insn, &vcpu->arch.guest_context);
> > +       unsigned int csr_num;
> >         const struct csr_func *tcfn, *cfn = NULL;
> >         ulong val = 0, wr_mask = 0, new_val = 0;
> >
> >         /* Decode the CSR instruction */
> > -       switch (GET_FUNCT3(insn)) {
> > -       case GET_FUNCT3(INSN_MATCH_CSRRW):
> > +       if (riscv_insn_is_csrrw(insn)) {
> >                 wr_mask = -1UL;
> > -               new_val = rs1_val;
> > -               break;
> > -       case GET_FUNCT3(INSN_MATCH_CSRRS):
> > -               wr_mask = rs1_val;
> > +               new_val = GET_REG(riscv_insn_csrrw_extract_xs1(insn));
> > +               csr_num = riscv_insn_csrrw_extract_csr(insn);
> > +       } else if (riscv_insn_is_csrrs(insn)) {
> > +               wr_mask = GET_REG(riscv_insn_csrrs_extract_xs1(insn));
> >                 new_val = -1UL;
> > -               break;
> > -       case GET_FUNCT3(INSN_MATCH_CSRRC):
> > -               wr_mask = rs1_val;
> > +               csr_num = riscv_insn_csrrs_extract_csr(insn);
> > +       } else if (riscv_insn_is_csrrc(insn)) {
> > +               wr_mask = GET_REG(riscv_insn_csrrs_extract_xs1(insn));
> >                 new_val = 0;
> > -               break;
> > -       case GET_FUNCT3(INSN_MATCH_CSRRWI):
> > +               csr_num = riscv_insn_csrrc_extract_csr(insn);
> > +       } else if (riscv_insn_is_csrrwi(insn)) {
> >                 wr_mask = -1UL;
> > -               new_val = rs1_num;
> > -               break;
> > -       case GET_FUNCT3(INSN_MATCH_CSRRSI):
> > -               wr_mask = rs1_num;
> > +               new_val = riscv_insn_csrrwi_extract_imm(insn);
> > +               csr_num = riscv_insn_csrrwi_extract_csr(insn);
> > +       } else if (riscv_insn_is_csrrsi(insn)) {
> > +               wr_mask = riscv_insn_csrrwi_extract_imm(insn);
> >                 new_val = -1UL;
> > -               break;
> > -       case GET_FUNCT3(INSN_MATCH_CSRRCI):
> > -               wr_mask = rs1_num;
> > +               csr_num = riscv_insn_csrrsi_extract_csr(insn);
> > +       } else if (riscv_insn_is_csrrci(insn)) {
> > +               wr_mask = GET_REG(riscv_insn_csrrwi_extract_imm(insn));
> >                 new_val = 0;
> > -               break;
> > -       default:
> > +               csr_num = riscv_insn_csrrwi_extract_csr(insn);
> > +       } else {
> >                 return rc;
> >         }
> >
> > +       #undef GET_REG
> > +
> >         /* Save instruction decode info */
> >         vcpu->arch.csr_decode.insn = insn;
> >         vcpu->arch.csr_decode.return_handled = 0;
> >
> > --
> > 2.54.0
> >
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
