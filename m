Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635625;
	b=ypyVm5fy88D3tArPUPk08Qz2yQU4c1x2/83UvUwwF1RFQzu+iIAii2YECmqTsl9V1x0B
	 pSr0X5X+icm7zdGvPUlrdXC/VO6JLfeHUa1J4YhMKAPv63Is9ctqW+nlJrvONgbur27Uk
	 EePpc9zBpQS5hh9mj/PDijlN1tO2ac7mct9aOCHC86TqqQtKG2+zw30E2qLCXMo2vOUE2
	 T6UZ+e6WHWCTl2DpMU8uxqLtTjcl37h8EnvjvkKA9jaSvQ32PEH1wASTYbKv+IqyF2Gtb
	 nc5Dhlja9JybNnR16OCJ2NMyqA4xoZ05l49b9OxifT/8YpeiUrCD9i8jDkwraiV3CZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=9A011GwDGlG1py2D4N87gJQuX8ar0m5xB7Oz/LEhEnE=;
	b=OiasE1iIBs+W+jo3nanGHMGKyUacaFGQjLi7wZQVkYoFShQbsMDrr/IqRzgvNQznIXoe
	 mV0vXRp7JeruuxIvOBmzciV2+R2Wo83cBZQb8EKIP2TOG8osTgPUaU+BlQ30EV2pfodMk
	 +WjoE8UuP3Q8y2PzmzIpxjnQQykBuvdC++mibLiFWAqmyPMZadVCEUH6sYirfbRCXjq2l
	 Aje88Otf0k42FlXKpd0Jn/jZgXv/yKb/fxVAHfOEHMzb9wPfDIhiPuVRejLnUVpB2NHRj
	 2F6zpnvK466H4YsSl80W5bOzr1mokmbKUfFerwQqRqtx2NHhihf1miet5xp5kBSxiWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Eckaxjdg;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C5606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 19:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B01C5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Eckaxjdg
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b41e5a1719so2642091a91.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795635624; x=1796240424; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9A011GwDGlG1py2D4N87gJQuX8ar0m5xB7Oz/LEhEnE=;
        b=EckaxjdgaDF5mThZ4+h58P4VsPDsi/ZeXmTrk0WIn2vCojkLZ2+iVD6aqESiUlTAJi
         GgnmvTYLeGf+I3rqtT0QQNuZ+mBtlw9UhSSrpHKR8dDqPfj7X41Hagst2vxi5D28oNpE
         ttoMoVQ+5E1Q8PpqGSAa7LAypesEvx4t+Sz0XdGILvgX4t3d7K710Lv2DlceWs0bIByl
         PEPsS6Xes30JsdmoNteiXgDmPBYD0y+THHCC1z++EMeOhzhywmjTXrq4hXu39+2uV6sT
         Vyj71u76ScKty8RpJhPt1HWS8kgHtX4gVo150Ccn0EFxMEoeJSTjuyWX+D8KUH+xpy9D
         qFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635624; x=1796240424;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9A011GwDGlG1py2D4N87gJQuX8ar0m5xB7Oz/LEhEnE=;
        b=0BIcPW/iOKmVSNSaMNSJzIG/d6nITq/xFd5Gc8BF3K42DTeBIyMK81gZWHTl5yN9eC
         O3pxSMJw/M2c1W6PsMH8IKa8iWBCZidtf93geSLlj6Lz3I4jCnEkkp6BXOZdttUtbpq0
         NByvsbV/rwWQC/9eGWfrIl3kIvLhosvbdqEzUxTSnJyKep6P/1cYxCcv9TIL99jLLNk6
         6egTU7PYklpjHSKx7ez1Th79+ORG/ySPoXaO0QY9wgz/+ZRVgtBB8sR+kFvZjRJazdG9
         95aGbTtwMBf2KnxGXWHHzjvndxPBCXR7ROA2SSK2y1N/91dhvLbOFu6mRkqlooZVCcVS
         6hZg==
X-Forwarded-Encrypted: i=1; AL+hErE5YlAPXqlshX8gDmJVOP/L7tNdWW9fbsfydD51RL00sslMQxCgYW+T6iHOXywcdSALTkE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/F4bbHwDhIlyqh7m3pARv4ftIQeIWD53r6syImx2Ju0y35LO2G
	OKrIoKwBB29W2u8LiBFnKUUtCDWnDOOZZP5ehhUXtruYZfFXm44sYx8bXXHkemM2sQ==
X-Gm-Gg: AZFdTZcOzaVKzKEB1rN7f2SkDVAvcXr3T1xk+jN7FVCs9FVrQOtRwJAb7iG55DkTfl1
	XKbp/Pv4PQOuGhRxvsNROiFa53PccOxe8Bxswn4AK2CYg5+4UOChOsZWVFnd2UtJcJLEEehboEB
	5LkaKIronmpWzf7pCnFUnFq8ieY6bzFVYz3MKNXyVgmBQtQ/ny3GGQARjY6IsHf0KLxwBQi6jdK
	fPzTip1z/U/EkfQde9wNDOPRtYYEZWE+zd5BzfkLynjhcf6PSjm3SyNkXknbCxcJJ08qnEgYpKQ
	IstRzJtAXQTVzNBC5a6qzkhGjfEfC7r4H/+9cw5lUTt0DF8AN+CE7jqKZXQ1JER8gtxl9kTk6/5
	+P10xCAsNIwpm1lmTMwv2IeXjHItnv2S0QzgJBjdwp/n7I/WrWtMg4sjI0AOO/tCkBjKVTQdR5N
	8HfBqmiXDO8kwoYSj3kaC8hnr0MJaUy3u1GbWM90ELUTiX3x4+IMAbUrHDTqstrAKbQSOTdCjAI
	sE9bIFWJKNh16/wCKjuHeSCSgGxfWREQ+fLRl440W3IaKBwdx3IHGiTvZcr6pQjtkmX4xCtL/Tq
	roF5L31tQqeYDFwD4jIqpjPhANgccyDE2ESKgrRF/9D0L/GRNBB/+D9h5zmnfFvSmG5rwEcPg63
	e5GSTQYKSYQ==
X-Received: by 2002:a17:90b:35c2:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3b41c8e0c7emr16015888a91.18.1795635623451;
        Wed, 25 Nov 2026 11:40:23 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d026d6fsm9518881a12.19.2026.11.25.11.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 11:40:22 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 11:40:22 -0800
Message-Id: <DN4JPCW1VT9K.1HWW8L3LMPE35@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Aaron Lewis" <aaronlewis@google.com>, <kvm@vger.kernel.org>
Cc: <alex@shazbot.org>, <dmatlack@google.com>, <jgg@nvidia.com>, "Kees Cook"
 <kees@kernel.org>, "Andy Lutomirski" <luto@amacapital.net>, "Will Drewry"
 <wad@chromium.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] selftests: harness: Support custom command-line
 options
X-Mailer: aerc 0.21.0
References: <20261114132200.113697-1-aaronlewis@google.com>
 <20261114132200.113697-5-aaronlewis@google.com>
In-Reply-To: <20261114132200.113697-5-aaronlewis@google.com>

On Sat Nov 14, 2026 at 5:21 AM PST, Aaron Lewis wrote:
> Also update test_enabled() to match exact option characters rather than
> tolower(opt) so custom options that differ only by case (such as 'R') do
> not mistakenly match built-in single-case options like '-r'.

Please also explain the has_positive change, since it's not obvious
from the diff. How about replacing this paragraph with something like:

  Pass the full optstring (including custom options) to test_enabled()
  so that getopt() correctly parses custom options that take an
  argument. Since test_enabled() now sees custom options, only update
  has_positive for the filter options (-t, -f, -v, -r). Otherwise a
  lowercase custom option would be treated as a positive filter that
  matches nothing, and every test would get filtered out. Similarly,
  match exact option characters rather than tolower(opt) so that custom
  options that differ only by case (such as -R) do not get treated as
  built-in options (such as -r).

[...]

> +/**
> + * struct test_harness_cli_opts - Custom command-line options for test h=
arness
> + * @optstring: getopt option string; must not conflict with harness opti=
ons.
> + * @handler: Callback to handle custom options; returns KSFT_PASS or KSF=
T_FAIL.
> + * @help: Optional callback to print custom option help text.
> + */
> +struct test_harness_cli_opts {
> +	const char *optstring;
> +	int (*handler)(int opt, char *optarg);
> +	void (*help)(void);
> +};

KSFT_PASS and KSFT_FAIL are test result codes, which seems like an odd
fit for a callback that handles a command-line option. Please follow the
usual kernel convention instead and have the handler return 0 on success
and non-zero on error, e.g. in test_harness_argv_check():

	default:
		if (opts && opts->handler && !opts->handler(opt, optarg))
			break;

and in the next patch:

	static int opts_handler(int opt, char *optarg)
	{
		if (opt =3D=3D 'b') {
			...
			return 0;
		}

		return -EINVAL;
	}

The @handler kernel-doc above will need to be updated to match.

Also, kselftest.rst explicitly lists which kernel-doc comments to pull
in from kselftest_harness.h, so this comment won't show up in the
rendered docs as-is. Please add kernel-doc for test_harness_run_opts()
too, and add both to the "Helpers" list in
Documentation/dev-tools/kselftest.rst so test authors can discover how
to add custom options.

[...]

> +#define OPTSTRING_LEN 128

kselftest_harness.h is included by a lot of tests, so please use a more
specific name (e.g. KSFT_OPTSTRING_LEN) to avoid clashing with something
a test defines, or hard-code it locally.

> +
> +static void optstring_append_custom(char *optstring, size_t size,
> +				    const struct test_harness_cli_opts *opts)
> +{
> +	const char *c;
> +
> +	if (!opts || !opts->optstring)
> +		return;
> +
> +	assert(strlen(optstring) + strlen(opts->optstring) < size);
> +
> +	for (c =3D opts->optstring; *c; c++) {
> +		if (isalnum(*c))
> +			assert(!strchr(optstring, *c));
> +	}

assert() compiles out if a test is built with -DNDEBUG, in which case
these checks silently disappear, and nothing else in kselftest_harness.h
uses assert(). Please follow what the harness already does for misuse
it detects at runtime (e.g. "Illegal usage of low-level ksft APIs in
harness test") and for bad command-line options: print an error with
ksft_print_msg() and fail. e.g. have optstring_append_custom() return an
error and test_harness_run_opts() return KSFT_FAIL, the same way it
handles a failure from test_harness_argv_check(). That also avoids
pulling <assert.h> into every test that includes the harness.
