Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AE27EC7C
	for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787421510; cv=pass; b=vCm0pEU9rUbqndgvmaG3PuN6KwCSPWz4JFr61Ml9OP/VApGrgaqv4+TBU2RB/RI03fAFnf2g3PxZQg3bo5mE4iIvpNc8cUvzSpJm75R0JGn3oBIHWvtDEINn81GvdwCYd6PbEq9mkOtLFgk1mSOvNX7fchZRTlOfD16TlAIZsos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787421510; c=relaxed/simple;
	bh=5uVSKut5uWA+O/bl1lu8n1UjU2a74/+vL2uiZFUMZuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZ7V8rV7/cEXAeBJs3JVvtxbgXR0kicjH+t5oJCdCMcSaeHk9TqhuazrywkyGt0d+votobux9h1dcXrM8Lo+3C7yyZJPgt4p1OR0RSGnhWmiQN699EuUpEnlMLfk0UhSxeaMiPcFoS3PRmWryo6EoGCSeTJKueYsGZPdvN2czaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWiZwmvS; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWiZwmvS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-499add6348fso22365e9.1
        for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 10:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787421507; cv=none;
        d=google.com; s=arc-20260327;
        b=sQ6rWKlatIuy8eyuAAg1073o8DQO6Z5UwlNqNp1DyNIkqJiHDQMtncx9EHbcOUsbol
         HaQH6WiSYDGKxXvu2FZ9eKcOLTUB1Y/k83O5KMp5DsblAyg3FCiFfHqIad56ZaNg/cK3
         PjgrOtZ9h25dDZkTTPv0nqUk/ClmaWrW4VvYyLc5XIbT+rDYodDu8o5+/waQfN+qR2uJ
         gwpdF7/rc3hvpUd8427q+3tdiqq/MYUBqwSEIzLRMmM+NSYif7Fg965Epv5TVImZrLm9
         UPaJCYHwK+JKeUPdR73QWmswSHnImb6SUhZsBXmtTANAnLL3s9TxZKGm8r+Re5FCx7g/
         N/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4zS3gK3kbG0uK+a0zea0r7Wu/L46iQSxpvjeCO3tlVk=;
        fh=DdouM1BaZh+6cVS0txDSksYotphtZjl7Q5QaBbq8Gpo=;
        b=Rdpw89fQ9XzvItRU2gOAmB6G6PGwO7d6lANGjPvp/AAAdvdxvZdchcMbCU6TnvMrVi
         Sw9UIs/bOd1ijSUvAK7IQ8l33sRs+Xp3rWcYA30MCRh9xRJJmasE8XvYCFHdYhqzx5pe
         OE0FLXgHlWl0UgWmZmTuBETW27qnmF20ppf87RNrKTZRyC/TR2iiMctYFz4vfHSkeOd3
         DSG+YVIQV3FPX5m0jegLvTlfTlsWhfXIyHxq6kA9kiuek59pvrtRDqRQADKR8ESnDVZz
         zLC14akgCk9EitNT9N4wFFEJ96wltP7mpDQssHSRKlVD5JKPBy9BjJThvXZqYO+sK9WS
         NNqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787421507; x=1788026307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4zS3gK3kbG0uK+a0zea0r7Wu/L46iQSxpvjeCO3tlVk=;
        b=wWiZwmvS8s45RXBFX0RsciQpbpEPC6lt1TTuXUQHlBcy3rTDlTcXiyGckT4sGRwzL4
         SG+foxXtf0YP/aZO2ibXNt+5YPbKV478dnLsNMDaDbYLqekRdlBTjehrs0e7xDWH7Gv5
         r6IE/S3XMcGIqEHC93Mh3y+3x9uh6gmMQ/gNiCF4J+wpBQ0nlUXwka1DeyFUxP/sJMi1
         wY180d05eBBmLPI0kah6ecPHkiSiCKA0ZGpyE5zWBTSGwy0W6lNVNZplDScgovwjK41M
         kVxSv6yLbxEBtLMKfr3baD34g3VQDcAmsRIAeSOHY6Sn1DCY50pz/eH92iczR3jr+j8P
         FFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787421507; x=1788026307;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zS3gK3kbG0uK+a0zea0r7Wu/L46iQSxpvjeCO3tlVk=;
        b=atszwni4K4HB3esZkf32dJdDWV0v1NutGZAqk6wm3PIaWJy1IOmarbNKOcpt6620NS
         RfZGCtQcVexWLd3veMBlNIWmfIIxFToAwiqmq5csdqkxULt/X1ohlY4RXbsfhhjGyefB
         KlPmBIU/RTMV/c8lK/JOlNwxfapjTnCVOy1YLS2AZNyoNdOTAFIgaG9rj/hEW2+88w7M
         vmudM+pjNPVKJAbm6CwXrqLwMFxzO0AFTjT44Tr+f6KUhYDtLZWOEuLiiaUYxjLJSUr/
         8HRgjRhc5CXev2q8HjgdKKLrFrH+MS2Z0yv4Bumq5lNY412jfqzeLwOHkl38R6zD1y4a
         itCQ==
X-Forwarded-Encrypted: i=1; AHgh+RozV1ZgIV1cBxqwKB1i+J+eP5xPcXSRcq6GVAGCL1zsSyqD4OMtH+wafWVt9DV0bNT2APU=@vger.kernel.org
X-Gm-Message-State: AFuF++kLSBL8em3g6kK+ZXfzxVSir+029RfGkLhhWrGpxtB0/ENKyc84
	o7MMP/thPlEMCNABmbhMPvYqctu9NJoNx3gxrv+2YQaGT0XesWVjlveYtUuMwoFJw6lxHkv0Nvf
	t+2SacoQcWtaqyVMkkp7RVZk3K+fSRdU/cs31Plho
X-Gm-Gg: AR+sD13dSL7+xqbSIb2wk2Q6iTe1GHKAu35W9U1OhXhnh9YeNs2F1CLLIpU/ZH87GSk
	iHJnBVsqomXIjtb1ZLNxv7FMLx+lU8XPZgNBEEwWwWaM6s0qcIOlO3OT/U1oOkTcR7/wMuP4Thi
	KjbDEG0frPwMSd5is27ZT1Ti7YNKHWdRbVK4xSolAIsR5XIVN3xU1XmpkSYYnQgD08DfxpeDlyw
	UyHdFqEIuoaLdhu5hd8cgS0eEp16/bxHOwSYZHVkp1RFn9yIc0YfUtqQyek6fUn2gerw/K6xmVo
	srnLRvB3WSoeImBjinKTkIIAldm1HDSaAPndvDV0uZhZy14J0IbbCp4dIAH+CYZNtwa+NPCcyau
	t
X-Received: by 2002:a05:600d:8497:10b0:493:b47f:a24 with SMTP id
 5b1f17b1804b1-499c1af1896mr748535e9.6.1787421506423; Sat, 22 Aug 2026
 10:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818112920.26252-1-likexu@tencent.com>
In-Reply-To: <20260818112920.26252-1-likexu@tencent.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Sat, 22 Aug 2026 10:58:13 -0700
X-Gm-Features: AcwNN1X_VXIwrCLgCNcnCbYWNahBq__ZqtblvwVpucn-WDdeu9vmJJAyLXBZxPM
Message-ID: <CACw3F52CfURHgdAhwQFXagGhijPZY4v1Njg709uHVf-20wRWOg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] KVM: selftests: arm64: Make sea_to_user skip cleanly
To: Like Xu <like.xu.linux@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 4:29=E2=80=AFAM Like Xu <like.xu.linux@gmail.com> w=
rote:
>
> This series hardens the arm64 sea_to_user selftest so that it reports a
> clean skip on hosts that cannot actually run it, instead of aborting or
> silently passing.
>
> The test drives a real recoverable memory UER through APEI EINJ and
> expects the guest to consume the poison and exit to userspace with
> KVM_EXIT_ARM_SEA. That relies on host and firmware support that is not
> present everywhere, and each unmet dependency is now turned into a skip:
>
>   - EINJ injection is driven directly through debugfs, and an unusable
>     EINJ (not built, no firmware support, or not running as root) is
>     classified from errno and skipped rather than mishandled.
>   - Guest memory is backed by 1GB hugepages; with an empty pool the test
>     now skips up front instead of failing an mmap() with -ENOMEM.
>   - Some firmware only arms EINJ poison as part of the trigger step that
>     notrigger=3D1 skips, so nothing consumable is left for the guest to
>     read. That case is detected and skipped rather than reported as a
>     spurious KVM_EXIT_MMIO failure.

Thanks for these fixes. Just wonder, do you mind also integrating two
previous fix attempts in [*] into this series:
1. Refactor run_vm to catch GUEST_FAIL, instead of causing confusing
unhandled MMIO kvm exit.
2. Sync far_invalid to guest.

, given the high level goal is to harden sea_to_user.c?

The first one will make the test result less confusing for the runner.
The 2nd one improves readability. You can re-use my code in the patch.

[*] https://lore.kernel.org/kvmarm/20260130192837.890688-1-jiaqiyan@google.=
com

>
> Tested on an arm64 host with CONFIG_ACPI_APEI_EINJ: on a platform whose
> firmware places no consumable poison under notrigger=3D1 the test now
> skips cleanly, and the earlier -ENOMEM and abort paths are gone.
>
> v1 [1] was a single patch doing only the 1GB hugepage check. Following
> Marc's review [2], it is expanded into a series that also fixes the EINJ
> handling the test depends on.
>
> Test Results:
>
>   Case 1 (echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepa=
ges):
>
>   # timeout set to 120
>   # selftests: kvm: sea_to_user
>   # Random seed: 0x6b8b4567
>   # 1..0 # SKIP - Requirement not met: get_free_hugepages(backing_page_si=
ze) >=3D VM_MEM_SIZE
>   ok 1 selftests: kvm: sea_to_user # SKIP
>   # 1 skipped test(s) detected.  Consider enabling relevant config option=
s to improve coverage.
>   # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>
>   Case 2 (rmmod einj):
>
>   # selftests: kvm: sea_to_user
>   # Random seed: 0x6b8b4567
>   # # Mapped 0x40000 pages: gva=3D0x80000000 to gpa=3D0xff80000000
>   # # Before EINJect: data=3D0xbaadcafe
>   # # EINJ_GVA=3D0x81234bad, einj_gpa=3D0xff81234bad, einj_hva=3D0xffff41=
234bad, einj_hpa=3D0x42c1234bad
>   # 1..0 # SKIP need CONFIG_ACPI_APEI_EINJ and firmware EINJ support
>   ok 1 selftests: kvm: sea_to_user # SKIP
>   # 1 skipped test(s) detected.  Consider enabling relevant config option=
s to improve coverage.
>   # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>
>   Case 3 (modprobe einj):
>
>   # selftests: kvm: sea_to_user
>   # Random seed: 0x6b8b4567
>   # # Mapped 0x40000 pages: gva=3D0x80000000 to gpa=3D0xff80000000
>   # # Before EINJect: data=3D0xbaadcafe
>   # # EINJ_GVA=3D0x81234bad, einj_gpa=3D0xff81234bad, einj_hva=3D0xffff41=
234bad, einj_hpa=3D0x42c1234bad
>   # # 0x10 > /sys/kernel/debug/apei/einj/error_type - done
>   # # 0x2 > /sys/kernel/debug/apei/einj/flags - done
>   # # 0x42c1234bad > /sys/kernel/debug/apei/einj/param1 - done
>   # # 0xffffffffffffffff > /sys/kernel/debug/apei/einj/param2 - done
>   # # 0x1 > /sys/kernel/debug/apei/einj/notrigger - done
>   # # 0x1 > /sys/kernel/debug/apei/einj/error_inject - done
>   # # Memory UER EINJected
>   # # SIGBUS (7) received, dumping siginfo...
>   # # si_signo=3D7, si_errno=3D0, si_code=3D128, si_addr=3D(nil)
>   # not ok 1 Exit with signal unhandled
>   ok 1 selftests: kvm: sea_to_user
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Changes since v1:
>   - New patch 1: drive EINJ injection directly through debugfs with
>     open()/write() instead of access()+popen(). Classify the open()
>     errno so an unprivileged run skips as "requires root" instead of
>     falsely reporting missing firmware EINJ, and report a genuine write
>     failure instead of the ambiguous "Failed... Success (0)".
>   - New patch 3: detect when notrigger=3D1 leaves no consumable poison an=
d
>     skip cleanly, instead of exiting with a confusing KVM_EXIT_MMIO.
>   - Patch 2 is the original v1 change, unchanged.
>
> Not yet addressed from [2]: dropping the hard 1GB-hugepage and 4kB
> base-page requirements. Suggestions on an acceptable backing scheme are
> welcome.
>
> [1] https://lore.kernel.org/kvm/20260817080759.25601-1-likexu@tencent.com=
/
> [2] https://lore.kernel.org/all/86y0le9cvz.wl-maz@kernel.org/
>
> Like Xu (3):
>   KVM: selftests: arm64: Fix EINJ handling in sea_to_user
>   KVM: selftests: arm64: Skip sea_to_user without 1GB hugepages
>   KVM: selftests: arm64: Skip sea_to_user when EINJ places no poison
>
>  .../testing/selftests/kvm/arm64/sea_to_user.c | 75 +++++++++++++++----
>  .../testing/selftests/kvm/include/test_util.h |  1 +
>  tools/testing/selftests/kvm/lib/test_util.c   | 15 ++++
>  3 files changed, 77 insertions(+), 14 deletions(-)
>
> --
> 2.50.1 (Apple Git-155)
>
