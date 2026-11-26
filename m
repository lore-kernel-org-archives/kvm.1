Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709060;
	b=Vtm6YlQ36DvdnIsa128QKeaePiS77F58S8U0pfzRSc7N0GNpCRJiVuraZxYgfiImNd4U
	 s0IkqT3hTYjg9yOKDamXafWfnKV2qdt8FiGDQoi2QoMmZFNTaZSmmCWzHjRd6zj73jn3F
	 DslDCGuaR6CBulsPXNfI2JE+YE+Dnp/Qx44OEJu212/52aprlC1VD/bQLxGHuoIp2Oz6G
	 9KyFM0JyJlqWi5VmHWRmpY0AkMzqe7/Bgdgd3JbEp2vTuovvKycJ2WeF6ZlEmvyND9sP3
	 iv5HeZGSoPNLOn3YqxyZgair8FW8hZZQspt7jVjp9oEuiIS1V8B0vdUGpcSAcuG9t7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709060;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FM9Vam4kTGC7ZguN3Mf/9Uy1IPLYUcx48J7NI69Tv0k=;
	b=yY0DCulYx26UCFAD8hquUlTNcueHrb3mdtwqVb94vJ94iZJkUFldaTPWRIej4Oe64owB
	 dMqRldXHPWCtfDxvAOF5l7paM8Q1udbgokOIxMFMOgvASNoESEFAkgk0HZlOLWTeT8FPB
	 VtlG+406jt86uy8GWLTTqSUx0KEIS+AbhhjB7a0rlzMdn4lKbBubVqjykKeIfTluJjMLU
	 n+fOfjo1cr+iE9JDZFv+73FrXZZu1qzsk6StAgf9inyhk0uGOIxkdVeevZiLcvsRMkjtL
	 SYxOb7PsvUT/cAnJr8ml2IX2TZsoyh7mZcfc4oJJZeURj3jYFOdtv8hGPLEOt+N7VrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DgWF8VqQ;
	arc=none smtp.remote-ip=95.215.58.44
Received: from mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94D606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 16:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A94D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DgWF8VqQ
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KvYTWhmgFA/7q0/gOgwk/b75Pcjh6jc73t+XjLOhpug=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795709057; v=1; x=1796313857;
 b=DgWF8VqQW5F4So20RZnlTpUwgcC1nZZ0whGnut8NKp6lKnu5ACqeZj3AwGXiTlpqp6r9kPT+
 onY+We/fSp3ztd/9jngf3dxkTcfcDmy00ZvTe5V1aYk7LtBLGm6fG2SSt4o5zXCA5pUkx6Ro8mi
 11rsDnxuhiD6+bTLqN3I16LQ=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2f737111322c38ef;
	Thu, 26 Nov 2026 16:04:17 +0000
X-Mizu-Trace-ID: 2f737111322c38ef
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 17:03:34 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com
Subject: Re: [PATCH kvm-unit-tests 0/6] Test runner TLC
Message-ID: <awhYIQTqx_Jgz2Qo@orel>
References: <20261126103002.2145135-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126103002.2145135-1-pbonzini@redhat.com>

On Thu, Nov 26, 2026 at 11:29:56AM +0100, Paolo Bonzini wrote:
> Some cleanups of the test runner, dropping some fat and preparing
> for future reorganization of its functionality.  In particular I
> would like to introduce a better waiver mechanism that does not
> require changes to the tests.
> 
> Patches 1-2 remove the errata mechanism, as it has seen little use
> and kernel version checks *in the test* are not a good way to decide
> whether a test result should be waived.  While the original purpose
> was to block tests that are unsafe and could cause the host to hang,
> unsafe tests arguably shouldn't exist at all...
> 
> Patches 3-5 cut some of the environment functionality, specifically
> not passing anymore host information to the test as they were not
> read by any test.
> 
> Patch 6 finally makes unittests.cfg parsable by standard .ini syntax
> parsers, such as Python's configparser.
> 
> Paolo
> 
> Paolo Bonzini (6):
>   arm: remove usage of the errata mechanism
>   remove errata mechanism
>   omit "#" from printed command line if INITRD is empty
>   do not pass information about kernel, QEMU or target via environment
>   drop --enable/--disable-default-environ
>   switch unittests.cfg parsing to be ConfigParser-compatible
> 
>  README.md               |  44 +------
>  arm/debug.c             |   1 -
>  arm/gic.c               |  10 --
>  arm/pmu.c               |   8 +-
>  arm/psci.c              |   9 +-
>  arm/timer.c             |   5 +-
>  configure               |  26 ----
>  errata.txt              |   9 --
>  lib/errata.h            |  58 ---------
>  run_tests.sh            |   4 +-
>  s390x/unittests.cfg     | 257 ++++++++++++++++++++--------------------
>  scripts/arch-run.bash   | 131 +-------------------
>  scripts/common.bash     |  85 ++++++++-----
>  scripts/mkstandalone.sh |  11 --
>  14 files changed, 198 insertions(+), 460 deletions(-)
>  delete mode 100644 errata.txt
>  delete mode 100644 lib/errata.h
> 
> -- 
> 2.56.1
>

Besides the suggestion to keep/deprecate the configure parameters,

For the series,

Acked-by: Andrew Jones <andrew.jones@linux.dev>
