Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA34219EB
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820751; cv=pass; b=EiJ6v+Vl71oMLIbmmA25CO/CHdaZLodOy7yNvwxyNAq+vc7rELXnRrEOWqTE130mq54+AKdwsuXD5jY5S91NtqBVyjjU1U4wQQB5wlytHXrWzjUBGojL7+oHneU5kOWkz2VbeH7ojkYKse71gDv0QzoB3bFtPO4CWMqbYgBqYRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820751; c=relaxed/simple;
	bh=TQ0YkjZ6DaYWwBevwDIkK78Ix7JVxyhaUN3xT4LANLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDJb8HrHYeqai3EcId1wIoMSDdwjJnOipfbcS08jdAS8puwYzyqR0ggFR/MPYjQkzhaGZzEIHj17QkzE1ohwhXmBCTbCl8eOAiQw5FvidS6EGnVK0T3LZ+793znX0cjaEYVVPpGv38787O7fRsFBNMHsNjLzB6IE6L5rFBYeHzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPIsIoVN; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPIsIoVN"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso23a12.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 11:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779820748; cv=none;
        d=google.com; s=arc-20240605;
        b=M6Ggb72JjlUsYfCuuKUrb2Gb1vKlGsT5n9U5W2QbqoH+7wYXGx5//Z4GHYAILvO1CS
         oOg+tPQD8+upHlqZGH21lbn+U2l+b60+5dNU2y2BkhB0KptJ7PO5m+udZfRhf2zun9bh
         ugmoNZg4n8FeTv97W7tqFsLkx3oojOUWhZgRrMHZms7CpjlXe3/MhTiE9cXdhZEYMAPh
         Vf4oDPGLCo/UdT05i00yw2sG7rbByZf6S5ttD0RAw9TA+y1Qa32b/s42WHPfu6kdttCN
         c4X+zWUAYLM2yYN9PRtr8E+tMEe8f7vx+UNEjxh5RAZvlsDEAzMl+R5A242aaRJBDY77
         021A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VZrclRlrLw1F8/3daiaKppXoN6r8/1TCSncdy3RzcBA=;
        fh=+J1R3Nbrz7zxU1gpQnDEZJ0CeATkVYEWAOQQlNRSVKw=;
        b=eLOXOdQ8ZK25A8cNfenC22vtYkDjLLn0WaQWNzurHbb+zhwZxH+IqUsy4RmOuY6IG0
         h5h9U41DmeHP6FGFBGvUA2skIs7kkOquJcVPynNPmONOhh4xMykAwvceaAUBZqnlWrLJ
         HfxHgoOLGcLli8mE0i6Ps3MiHYlCUr1D91+n66kJBMmKc4UuoOKfFmLWnC0bhoUjCZ25
         zteD+kI9/nhvO6qFXmDS84hSTDlMhxO6fhnbtY0bxRZLyItim0RrVgbCoPNUt5xNO4mI
         cZfNcVrT3u4Zhyw9SLWQCe7NVO0qPUdDgVXj0G+m5VzcoTl2ZuiI6U74PlDkJtvQ+5xU
         YA8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779820748; x=1780425548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZrclRlrLw1F8/3daiaKppXoN6r8/1TCSncdy3RzcBA=;
        b=MPIsIoVNsFdVMXJRJ4ZnH14jWU4ca8f7NkGCg6OAxzPUqUSAdfZZWDa+NI/ifUQwpf
         tjJ6pel86DJ6t8+IbHotRq0rZeCPYIOYZgFkReIrfyzzQ4Y6RbAwG0H1hdEH7skxfJU1
         JIyyf9GjoYxXIOiRD0ufFJjooc2+jvhT/gC/yPB35e+f+7yYf43YQ0RXbn2Pgi5M9ztJ
         TO6Otmu2wriiUTSupJpwMGdF6F+I5AJWdiNp9F5qgQmHC3HReDq+V+hm74JqQ4kEduaB
         VUpwR0QMHtHAFlT6elVpKDxw6bWpFFAeP3aEzEPYOGzN9IpsLIgZFF7WtAbFhK6veCUh
         u4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779820748; x=1780425548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VZrclRlrLw1F8/3daiaKppXoN6r8/1TCSncdy3RzcBA=;
        b=JSF9ds1PItBYpMJe83oMiKxrw35Ihy/zuOQEGmVKv65qDiP7GhCVwkmXiHivB74z6K
         OEWk/uDq0dmHvXX/0SD0yun1p4aHwlA/e87qS9RAVQk7AQUeLG3IR1ehqkWOLJ/NZCC4
         17Pui6vCl6pn/LGTLDQe2765JmvPL3ApfXTTc8QQfpOk599FxTazzOpVo1efbVPc22XW
         Czf3hS/esGt/sZ18Sd897QCPl4gb+l0EDklC8qlJxcpBToTQ5x2X/DR8RkAZYQy4R3Us
         lF8b6XNDgPXFsJO/eOvuMT+4JczF3nUItcScjNis7Kzve8T4zhM8tBp976ApPDyJFakb
         rQ8w==
X-Forwarded-Encrypted: i=1; AFNElJ9el7VIxRDnDYBk9cfycDB9XyjEQ3Kmu4ktU0l6WPzgqJUQ8dnRJF8wMDyasNQYCvFa4U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74gziMTqwdiEeNXR0HpHjxBJkLudFMZ6mAyD1P8D13gGrxT8g
	QC3DORbq/mgxKB1aOhuFBBn2v5mZIa948KDZPAtwbMetbvE4z9G6awdTDJYD/PXNZ3jXfOje8mc
	S43+xkyTWyotj9sq0CecaP+IW7d4E4Te8fAV9pMvM
X-Gm-Gg: Acq92OEo8sKP6iS51aQL2FPVjA09tdZR/xEI40Yu7GFDW+puaunPaCgP5ROC23GC9Ui
	7JtbhpS7rMTzmHkAGEyyX3d0fIC+l3r+5Ctspau0iUmTVQsNj6KgRMFXEA5eRuFgMyyNHFXBCO2
	du48LHJs2QxnpEOAy9saVruKNb11of5PyPRBdq1OvfI/daVZoxxCMINFGxINq//RCWRQ03+52O8
	LecnKv7c08P26CEPj4qKyBX6o+uEin6AdpnRwgSvi0hv92YIPnkiOY5yC1peOfBFK1b+7N0ryqs
	mPhJnBpj0hN8ytdUow==
X-Received: by 2002:a05:6402:5356:10b0:66e:e3f9:ebb6 with SMTP id
 4fb4d7f45d1cf-688fd0d56f7mr134060a12.4.1779820748207; Tue, 26 May 2026
 11:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com> <20260513224608.1859737-4-jmattson@google.com>
 <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com>
 <agXcKDjnJc9DPcyr@google.com> <CALMp9eS831M153QmAgjzJcR2dFY_wCCCzDisd7_T6GyS3-gAFw@mail.gmail.com>
 <agX2SJF3rJSkIqDe@google.com> <CALMp9eQTSxFkVf4vV83yNYvv2AjseHYiD3M68mcc951L4U1Jxw@mail.gmail.com>
 <agX5v1utAfyMadPm@google.com> <CALMp9eQqbHrcV1_WM+5xUR16OpGk+unxoZGi+=t55cqVhFgAfQ@mail.gmail.com>
 <DS7PR12MB82016B1B310BD994C83B35D294072@DS7PR12MB8201.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB82016B1B310BD994C83B35D294072@DS7PR12MB8201.namprd12.prod.outlook.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 26 May 2026 11:38:56 -0700
X-Gm-Features: AVHnY4KO9YpPS3F4eK2yFsOKV_kGxdvJkMqyQHd9reQ58QYwde_VG7jCuT3Sxr4
Message-ID: <CALMp9eQ2SLq2bVngJ1RHEfkFe5yaTDrFxXT0KNTgBZY6WRMDbw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ctpence@google.com" <ctpence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 11:17=E2=80=AFAM Kaplan, David <David.Kaplan@amd.co=
m> wrote:
>
> This appears to be a bug, as most other instructions (e.g. INVPCID) that =
have CPL checks do the CPL checks before the VMEXIT checks.  I'm following =
up on this internally...

Did you learn anything from the internal follow-up? The ellipsis
suggests, "stay tuned..." :)
