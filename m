Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A61A6815
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140650; cv=pass; b=ZqDNKOnql2j01k3MIr2eVB+nldUx/gODIttppENhklPNdnzjfOce8YtRVK7Yo/kO0iDIcqoKLDUuNkRMaLfKV9R5dIDCfOjKOCClMsfURZ7JYvxzF7gTtWM5DCOzYNnAsJ+JhFGm1cp4V7QiL/6nAZurrR+xe1Pb+ECO4gyrgcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140650; c=relaxed/simple;
	bh=Z8T+WqfW8gPngsoZIlqphQxVNZn8CAVdkbOPghqY/9w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE6MVQ2DoU5MgTMrNkgvP6bq5d9mhQxNgoG42zLy7YXOen03MNClUO6eI1UO1xqhbSi84QKs96CRZK2gM/wZouXxkox5ktSvl0fzuIPCMV39wcwuMSbqeyjNfBLvN6+sBJB33F8LLOUWSZN+rvU4t2VJVKoWz3cZTYlevsrC/d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXmtDQdR; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXmtDQdR"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13721dfd471so9612627c88.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 18:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781140648; cv=none;
        d=google.com; s=arc-20240605;
        b=im65SZ9RoqctfpxRJmo7Gjw+h1JzIOI+MucObSehFxsRqACm+TWvnCkSZ6I07UnGl1
         tMjJzVeHg0lxPKtpgRVQDIKps3yE+082gi/Aav+bGEDZXjCmitlc7v4iINr01fdoirz7
         72fxG2IRG8NUt2nx0O7uehmmdmyZAOz5hQ5TFoZ/8/WehQAoRruX+g9GvjBGu8YvD/eE
         /hQraz1Faowywj9CLzlJrmHUfZGarQ/4716oHRmVWTIsFnpLaFuAVMzHe36Mg3fO1aqH
         fUK5vDEYe0ZN55iYGrpUZAFU6jD10LOUiIzDkjabgesoxkl5QVY15XCli/C6JJQzDCie
         4ooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=bjdIvKAE9+v5d05DIespxf4RX/qjcteADqi92OtX9xI=;
        fh=w4zvKM7eKSrwN1G3DyHJ0dfsJJaR7g/0zY0D/TF0G3s=;
        b=dZj/aTey5/xs1Pol1uBM+pCiBJbw6vkE/cWZdGn8LCoT9MkhMrJy6nV/XefVFUC0Pn
         33lez7mKuUY0zPAPOglyHdZYuCPqjob/10R0d0Bw/CsM+EZOudufd4ov9ukpCOuaBFwk
         kLUvT2/z/Q1HoEkEL6lhcHT4HsKJ4H0zKE4FIhxDKwVuUAkPyYxKb95Dl6JfYnIbiXun
         KDnGCQqgSt5wYNHlH77mCbg8IwEIPzkhIQHD98b/G+RfKa5FtGgK92iMsUZD+fXSgmYv
         rpNCS9wxEqnuUmBV/HQ0AUNcc6fsZCbA5ETh9XnT7lQ3S7lpeLRRNY3Nv67QMONy4q2A
         1zdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781140648; x=1781745448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bjdIvKAE9+v5d05DIespxf4RX/qjcteADqi92OtX9xI=;
        b=NXmtDQdRiu40ZCIWvzRhOJkEM/rYE13gdo85YLWZWo7ozW+0s+CQu+5uz05ZCxXR3q
         54AAG5ykFTn+6tJOJa0OANRDDuKcSvWX81Xe9UBAeWxr22oHlYRn1JN+oPS+6GYWt1/W
         cMBF2f/54a1p8BU4zXFEvQIXl8pUZLfkoahixJH80iRmnN9pFiCqWPB09j5J/2r98Xzi
         M512edqxWKBEVxpTRSJ0gxCGYHnk5fCxEtk1CTXWQuICWaoMJcTEr2Mb21IH5egBSuAM
         TqKz9f/W38cVEaqhjorOXj52BRr3VM6HsH40gvWXkc+ODLL45zaj2UalFX+BbJtDQ/vK
         /+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781140648; x=1781745448;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjdIvKAE9+v5d05DIespxf4RX/qjcteADqi92OtX9xI=;
        b=aUo7gVcrRVZ6MrWLS+im3Hhz0egRZChQvan+Gtcxs/nMp3vsf2B1wH3ABq4Xx5Rib7
         uOnf+/u7xaT8rHQN29TM4tft7CiKVHdWCLNsDcSJA3WdK5T6Ul1bLPNMxcCDeXQhXmJe
         bD4wE2Wo2inU38fEyRY5GVlLU15nHot1n2MLRqg4lqp3uWHC2q4Xp3TUnK2w7clV/Mnk
         KwjPO3iQpCEPI4dqdAlcTLUXE2wcHKkzK4m16x3RoUsyp7RM7aot7+3OyGInZy3EmW0a
         up6tJeGNinzyPrbNCieO5mUvm5yaBWub/CmW5pJckq6daK65If4FeFz1bjNKDra6igKW
         zB0w==
X-Forwarded-Encrypted: i=1; AFNElJ/7uFGGC3Xe3CQdvekYHX7n0JK4bn2Sh/6dBwYCLNJOJeQiEWGow4JAdHAYDMn0qyhGa9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMN7WyfuC9pA2uLBKQF3Yl1S6Hhs1IDHcoZL+zYz+16stYuPD
	OjZ8cLF42GTl7sL7Aix/egkr5RI58zL2jJUVz+ak2mP8uq0cbI0i0+i54i2cgoVvkKeqJ72QquP
	OB3+dJZrveRLZvorIbILEoVKFUvAe7xlVwhk1y1q6
X-Gm-Gg: Acq92OEgk7WmdYxj8Bsqy6xrpOe7cyzuBrFcZyomLjEvyp9MCYFvQw1aNvtM/5N6mDG
	xm6EVGuSe8jdz3n3YNczxR+lHLTv7VKLzs1mdTaxIL4/b3eyV5Z546DvFZ/Yqo8izFDFDpR4Kmg
	3Gk8z8KORV00CUrNB3q5oxT8+pP6SxESkH0TgpB59RfC1eFYMPoS1gUSL3AMPmR1DQu6YjD0sWf
	ebgk+0kcDZUPr184FPCa80bMVkCAQl8shd50pRxShTcP+eZtGCbeXdxZKnitekNFeU6Iey7Dw7r
	GJ5OqnDBDpkYyuwXXtWrHtmOS1LlaSqt3D813I7qwL1fhcBodQ==
X-Received: by 2002:a05:7022:690:b0:135:e455:e1e0 with SMTP id
 a92af1059eb24-13842161934mr353073c88.10.1781140647800; Wed, 10 Jun 2026
 18:17:27 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 18:17:26 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 18:17:26 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260331194202.1722082-2-vipinsh@google.com>
References: <20260331194202.1722082-1-vipinsh@google.com> <20260331194202.1722082-2-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jun 2026 18:17:26 -0700
X-Gm-Features: AVVi8CdzGmaVWznPyG5AyMjnV1Z4iECS6hmJp8c16LmKO_AaXBZJcKDEnsuZUaA
Message-ID: <CAEvNRgGrPKBXh=VA3QBLJOczKRpMOB4nDmZL0XRwV6B3PT_7+Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] KVM: selftest: Create KVM selftest runner
To: Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org
Cc: seanjc@google.com, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"

Vipin Sharma <vipinsh@google.com> writes:

>
> [...snip...]
>
> +def setup_logging():
> +    class TerminalColorFormatter(logging.Formatter):
> +        reset = "\033[0m"
> +        red_bold = "\033[31;1m"
> +        green = "\033[32m"
> +        yellow = "\033[33m"
> +        blue = "\033[34m"
> +
> +        COLORS = {
> +            SelftestStatus.PASSED: green,
> +            SelftestStatus.NO_RUN: blue,
> +            SelftestStatus.SKIPPED: yellow,
> +            SelftestStatus.FAILED: red_bold
> +        }
> +
> +        def __init__(self, fmt=None, datefmt=None):
> +            super().__init__(fmt, datefmt)
> +
> +        def format(self, record):
> +            return (self.COLORS.get(record.levelno, "") +
> +                    super().format(record) + self.reset)
> +

The commit message above says the printing will be in colors when the
terminal supports it, but if I'm reading this correctly, the colors will
always be printed.

I was expecting something like if the output is piped to some file or
like "not TTY" then don't print colors.

Would you consider not printing in color at all? Or adding some kind of
"turn off all display magic" flag?

I also saw code for a sticky footer in another patch in this series,
that's probably not nice for other stuff wrapping this runner.

> +    logger = logging.getLogger("runner")
> +    logger.setLevel(logging.INFO)
> +
> +    ch = logging.StreamHandler()
> +    ch_formatter = TerminalColorFormatter(fmt="%(asctime)s | %(message)s",
> +                                          datefmt="%H:%M:%S")
> +    ch.setFormatter(ch_formatter)
> +    logger.addHandler(ch)
> +
> +
> +def fetch_testcases_in_dirs(dirs):
> +    testcases = []
> +    for dir in dirs:
> +        for root, child_dirs, files in os.walk(dir):
> +            for file in files:
> +                testcases.append(os.path.join(root, file))
> +    return testcases
> +
> +

Sean pointed me here from guest_memfd tests [1]. The Makefiles allow us
to generate test configs at build time. For [1], I could configure all
the test parameters statically or at build time.

[1] https://lore.kernel.org/all/aiHeDZEPkAcWcSkn@google.com/

Perhaps for a future extension, but would you consider taking the output
of some program as input for cases to run?

My (future) use case is that with hugepages, I want to run something
like

  ./guest_memfd_test --order=0
  ./guest_memfd_test --order=9
  ./guest_memfd_test --order=18

And 0, 9 and 18 are the supported HugeTLB orders on the machine being
tested. I'd like to iterate over supported HugeTLB orders at runner
runtime instead of at build time.


> +def fetch_testcases(args):
> +    testcases = args.testcases
> +    testcases.extend(fetch_testcases_in_dirs(args.dirs))
> +    # Remove duplicates
> +    testcases = list(dict.fromkeys(testcases))
> +    return testcases
> +
> +
> +def main():
> +    args = cli()
> +    setup_logging()
> +    testcases = fetch_testcases(args)
> +    return TestRunner(testcases).start()
> +
> +
> +if __name__ == "__main__":
> +    PYTHON_VERSION = (3, 6)
> +    if sys.version_info < PYTHON_VERSION:
> +        print(f"Minimum required python version {PYTHON_VERSION}, found {sys.version}")
> +        sys.exit(1)
> +
> +    sys.exit(main())

This shouldn't block merge: why not align with the kernel's official
required python version?

>
> [...snip...]
>
> +class Selftest:
> +    """
> +    Represents a single selftest.
> +
> +    Extract the test execution command from test file and executes it.
> +    """
> +
> +    def __init__(self, test_path):
> +        test_command = pathlib.Path(test_path).read_text().strip()
> +        if not test_command:
> +            raise ValueError("Empty test command in " + test_path)
> +
> +        test_command = os.path.join(".", test_command)
> +        self.exists = os.path.isfile(test_command.split(maxsplit=1)[0])
> +        self.test_path = test_path
> +        self.command = test_command
> +        self.status = SelftestStatus.NO_RUN
> +        self.stdout = ""
> +        self.stderr = ""
> +
> +    def run(self):
> +        if not self.exists:
> +            self.stderr = "File doesn't exist."
> +            return
> +
> +        run_args = {
> +            "universal_newlines": True,
> +            "shell": True,
> +            "stdout": subprocess.PIPE,
> +            "stderr": subprocess.PIPE
> +        }
> +        proc = subprocess.run(self.command, **run_args)
> +
> +        out, err = proc.stdout, proc.stderr
> +        self.stdout = out.decode("utf-8", "replace") if isinstance(out, bytes) else (out or "")
> +        self.stderr = err.decode("utf-8", "replace") if isinstance(err, bytes) else (err or "")

I think it would be useful to capture stdout and stderr in order that it
was output, so that the output being saved shows everything
interleaved. I think the order could be useful in debugging.

I can see benefits in knowing which was on stdout and which was on
stderr too, so is there some way of having both?

> +
> +        if proc.returncode == 0:
> +            self.status = SelftestStatus.PASSED
> +        elif proc.returncode == 4:
> +            self.status = SelftestStatus.SKIPPED
> +        else:
> +            self.status = SelftestStatus.FAILED

Using this class-based pattern requires us to do
Selftest(test_path).run(). Would you consider using a function-based
pattern, like run_selftest(test_path) instead?

>
> [...snip...]
>
