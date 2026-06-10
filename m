Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC5B3A3E60
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078862; cv=none; b=aEV3JMgPp/8z14TGXCLK9W1jzl05tYaYofASfNMX16P3LYOyucFTM2tTtpIMOdyxG6yLE+w089/XSPG/VcYdwB9yqCvJFRBlwz6RwlLkq1WXf10Mut5b4l3FcKZzUd3WHKZIAzsjeDDmdTGvaJlviUL+AW6+V5kPyZPYEtUqRNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078862; c=relaxed/simple;
	bh=ISXFlZ6VuJctROQQPhUKN/m90ZDyh1DJ2M8RD/Zgn0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sfo65HcenKOhIjGnsid7XwI8cY036r9nW0+KtS0W1xOYZTehgeKmGebfnISf/pvb3pqtW+pY5B35kfWSmvHGZUgtqx6up8htV2RoUsFthUYX12AXhq5WfxOW9aG3BYfxBh8TkWcxC6yrgKWT5vfU5ajuJTuowc9pqUmeRi6geOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1QHtQ6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1QHtQ6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499AA1F00898
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 08:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781078861;
	bh=tHFaIE3mlfVJzr7RU1YJnRDmGM0Pda/Ijxz0rCMoekY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N1QHtQ6l3P6oGUQXdskDH+lDaiFJ5N6ggs1mG+2bmA78t+co0QukUXImVW7Vxw81M
	 8LOsg8Q9sC8PcgbkNFR1osH6BofcnG8+5TOlLWPRJHMG4Z0yo33wF+805Q4HmBTDUl
	 CqWhPM0jCVYx7WVbH7lAlZUOAedLoXbMDyGLEdcZXJf9YYoGqYtY53Gv12jypHcXCz
	 UcQib+Fi+J/8xsOIOX/d9vXXoSuG4kF17Oi+P2Fc4H5EKUXs0dP2VclTI6WAmN18+y
	 pYvWehehZCPsEjJOagxlPcW5sjMMki+6u9rDMpllcGyLr77uw7a0XuVsQ2/Sxb8b3G
	 FPZAf0jNVY98w==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68c1630159bso7318499a12.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:07:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+DCQ2ZY8+lIEWPq/87rE6HlbFZgLRIpxbn23qR71dbNUc64hFzDUGt7i5jwDnj2WKLRnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvlmDO7ijpTbFiCjVhR4QYhgbCaMq+SYlTIU6irmGDBXlbsM9
	nt33q4erjlf33DfwMlqlX8rlogPVcyLmcwnHaUZfOBvmZ3050n82V5NwOUFLDrZPI4pnwo6S6v/
	yi3kO4OMlwLSn6i6meceBqowOo/jG4jI=
X-Received: by 2002:a05:6402:1d4b:b0:691:affa:38cf with SMTP id
 4fb4d7f45d1cf-691affa3d97mr6623035a12.3.1781078859975; Wed, 10 Jun 2026
 01:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526125256.2511876-1-maobibo@loongson.cn> <20260526125256.2511876-3-maobibo@loongson.cn>
 <CAAhV-H7RUdVJXOdjktn6vox3crhcXV0cEB1kUgu_zUVV5qpihA@mail.gmail.com>
 <CAAhV-H5X1a96mwTBtpuyTZKWbnV+T9xAnX1CcHQ6EikHJpKJLw@mail.gmail.com> <3f0d18ae-594c-7ac2-07ce-3ce411ae0192@loongson.cn>
In-Reply-To: <3f0d18ae-594c-7ac2-07ce-3ce411ae0192@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 10 Jun 2026 16:08:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5DqJsR8vzJqJFhm3QKC7rcRDkC53_V3Gydqw7p0gWfew@mail.gmail.com>
X-Gm-Features: AVVi8CfB8eH1IpYUhx6tmvE5-k3_UGFXKtKFDf-UKmnQsoPSFtj4hpWZ6hSMsdU
Message-ID: <CAAhV-H5DqJsR8vzJqJFhm3QKC7rcRDkC53_V3Gydqw7p0gWfew@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] LoongArch: KVM: Check msgint feature in interrupt post
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:04=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/6/10 =E4=B8=8B=E5=8D=883:37, Huacai Chen wrote:
> > On Sat, Jun 6, 2026 at 5:54=E2=80=AFPM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> >>
> >> Hi, Bibo,
> >>
> >> On Tue, May 26, 2026 at 8:53=E2=80=AFPM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>>
> >>> Interrupt AVEC is valid only if VM has msgint feature, and this featu=
re
> >>> is checked in interrupt handling. Since interrupt handling is executi=
ng
> >>> in VM context switch, and it is hot path, here move the feature check=
ing
> >>> in interrupt post rather than interrupt handling.
> >>>
> >>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>> ---
> >>>   arch/loongarch/kvm/interrupt.c |  5 -----
> >>>   arch/loongarch/kvm/vcpu.c      | 14 +++++++++-----
> >>>   2 files changed, 9 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/inte=
rrupt.c
> >>> index a18c60dffbba..48dd56aa4dc5 100644
> >>> --- a/arch/loongarch/kvm/interrupt.c
> >>> +++ b/arch/loongarch/kvm/interrupt.c
> >>> @@ -36,8 +36,6 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, u=
nsigned int priority)
> >>>
> >>>          switch (priority) {
> >>>          case INT_AVEC:
> >>> -               if (!kvm_guest_has_msgint(&vcpu->arch))
> >>> -                       break;
> >>>                  dmsintc_inject_irq(vcpu);
> >>>                  fallthrough;
> >>>          case INT_TI:
> >>> @@ -75,9 +73,6 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, uns=
igned int priority)
> >>>
> >>>          switch (priority) {
> >>>          case INT_AVEC:
> >>> -               if (!kvm_guest_has_msgint(&vcpu->arch))
> >>> -                       break;
> >>> -               fallthrough;
> >>>          case INT_TI:
> >>>          case INT_IPI:
> >>>          case INT_SWI0:
> >>> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> >>> index df5be9b265e8..ebd432da3ca4 100644
> >>> --- a/arch/loongarch/kvm/vcpu.c
> >>> +++ b/arch/loongarch/kvm/vcpu.c
> >>> @@ -1493,14 +1493,18 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu =
*vcpu, struct kvm_interrupt *irq)
> >>>          if (vector >=3D EXCCODE_INT_NUM)
> >>>                  return -EINVAL;
> >>>
> >>> -       if (intr > 0)
> >>> +       if (!kvm_guest_has_msgint(&vcpu->arch) && (vector =3D=3D INT_=
AVEC))
> >>> +               return -EINVAL;
> >>> +
> >>> +       /*
> >>> +        * Clear irq with INT_SWI0 (which is 0) is missing from SW si=
de
> >>> +        * INT_SWI0 is cleared by guest kernel with the similar instr=
uction
> >>> +        * clear_csr_estat(1 << INT_SWI0)
> >>> +        */
> >>> +       if (intr >=3D 0)
> >>>                  kvm_queue_irq(vcpu, intr);
> >>>          else if (intr < 0)
> >> I think "else if (intr < 0)" can be simplified as "else".
> > Any updates for this series?
> Sorry, I do not notice it.
> yes, it can be simplified in this way. Will refresh it in next version.
Then you probably missed this, too.
https://lore.kernel.org/loongarch/20260526125256.2511876-1-maobibo@loongson=
.cn/T/#m05744b66990b2ae0c4511820eb903237c00d290c

Huacai

>
> Regards
> Bibo Mao
> >
> >
> > Huacai
> >
> >>
> >>
> >> Huacai
> >>
> >>>                  kvm_dequeue_irq(vcpu, -intr);
> >>> -       else {
> >>> -               kvm_err("%s: invalid interrupt ioctl %d\n", __func__,=
 irq->irq);
> >>> -               return -EINVAL;
> >>> -       }
> >>>
> >>>          kvm_vcpu_kick(vcpu);
> >>>
> >>> --
> >>> 2.39.3
> >>>
> >>>
>
