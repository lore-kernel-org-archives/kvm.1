Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC02DD5E2;
	Fri,  5 Jun 2026 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636227; cv=none; b=PsXDlhNeVqUdd+jkF6yGMOhRQkwNesqLlu1b7xfX+SM9ZHPkMIuPYlXLP061a4LULTiIrkC5VpQI+iVY9llaiYX9GJF747FOIMD7nQjoDJhnRDQzHG+MkZzeAqX2oWVQioCcazcctKR8Fnt7IQgv0RBKnfGfd+I7gPTZDAKHcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636227; c=relaxed/simple;
	bh=2ZcqJXsmrbBpKhPyQMBIArzTEmFadM28MZ9/IfA+daU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImluDGq17+X98yJK9+OsAbHsIPEdbjXyYu8PcI/AEnuCT2ySkZl0BsXMC6JiYCK6dmNvzuCMJsvktAQ2RM4CgYPL9rtaiSUgn5fZ4NiXNps6Yx3QruEohVRGrgWFMrRud3BQKwGDO9ykOHgn+TuwDomW1rsGC7BZ0goxnI9AoNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=V7biNQ3D; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=V/EwKI+P; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="V7biNQ3D";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="V/EwKI+P"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1780636224;
	bh=2ZcqJXsmrbBpKhPyQMBIArzTEmFadM28MZ9/IfA+daU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V7biNQ3DctMnlo8cMv5HHSMGtXZXVcOZL2Stz/dpF1N6PF08wHrBSqsPZg/i84dxX
	 IKd066O9YyRSS8rmpqhhsLpfbbd2r30bmJPNd45GCO6fwRlyD/0KQoEbyJ2Ulg1NnI
	 GCDOEqx2DiAlwTBAKNBSNcdJidvi9becaR/4ry2ssMxBUR0L4l//VmSCGTnzkuagiT
	 hd79Pas8pAUXGWVUXYNavDVFYOwmyO4vXRaTidZlnb8yccK8rZndtgfQMC4oK0c//u
	 E4igylSnkiyW+8i++0mQW94A2ZNLgEPMBBoCwvlnKRH7MIFhaOvCbFE3/05yFOTrRo
	 wgpqemsan6XN6D1z6bB4OHawW5iD6eYaEUlP/ioWsZOsPvOPmzwCuTADA5SZx601zl
	 9dFt4erElk6dlJxeZZvcsDopUpD7xNbXD2BvV29rhQkC4twJWWxBZL7sWZ/ci0yVpW
	 xa8PCgXlKS8f8Ai3rKoi11+s8mKHLL3XrVqdKEtmjcz9LqM1NJ8V8dO/tDX02snYmd
	 IwEArb9vco0jp+mtcWqzCp45cSL8R0MtfrnCSk7OzK+kf68apV6RZglg/sw6L2Groa
	 0Z+X2MquW0sMxjpYakJZpSTPhNvy/mB+AjXnBovV5UQSXZXYaqEDeBOHLoDu5vZwPE
	 E0j/wNVyeYJodv8B/sdvxX08=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 345361E920C; Fri,  5 Jun 2026 13:10:24 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1780636223;
	bh=2ZcqJXsmrbBpKhPyQMBIArzTEmFadM28MZ9/IfA+daU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V/EwKI+P6zhGP/r+9Mgv1zGYkS6O2PmVkcNNbGkxK2aaZ3eQl28uPRTETnnKIHUAG
	 jRb5VIO5EENKtZeAjgx/7pYyjO1N0xweA+j/ZcpHbDKf+CU4/qOuPYsZIxwkkRwwZA
	 flwnKLo6WNoA+QNR76TetVK7aimJ869zkEy4faHYQu3ADslDPBFmzQVxUlEmCPEMtH
	 9gnJ5NLFc6YdKH1SUHycaIGw/n8hv6NYWsOtRkDJdPbPhYjg+vENHmgtgug79+Qq2D
	 R1Te/zMEPRZ/tgoaLPFaRNajqwkmPUhag658oGaOQJ38ExzxeWlcABaxcUvizbShqE
	 vbTLOkCsPAEMC/cmiv7pozXXdTClxWmx5iD/VCxql+bJDt+sLgslpnMspN5WwQK6xP
	 CMSR2NqLG6fcdH0MMHqgp631RSU1xMlncHjf/vhyI94YSIdVeaq1ls4Bfztul1GFh9
	 GPD/UxBBLFqyGyg8NPmu0d23Zik84n4X2Ro7SfiYoP7Ai0e2SGAYQosIk5c/+5gHTG
	 Tmni9MdVXodKjxsixFVqQ8vdmnbh8dr009fYLjs87RIEOtknIkiYh5izg7tUGfqBMS
	 DHrGiwRPiJF++h3nxIUPPwyyi/sK6ppHNTU7GTLV11JnCXmtvHze0n+CEd0irOJ5fo
	 nk6QszY6ojbVT3ZTsNuevO4o=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 29C521E9208;
	Fri,  5 Jun 2026 13:10:23 +0800 (AWST)
Message-ID: <d7b56622-6455-4e80-844f-086a0a3b1946@davidgow.net>
Date: Fri, 5 Jun 2026 13:10:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kunit: Add example of test suite that can be skipped
 at runtime
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>
References: <20260604162805.556135-1-vaibhav@linux.ibm.com>
 <20260604162805.556135-3-vaibhav@linux.ibm.com>
From: David Gow <david@davidgow.net>
Content-Language: fr
In-Reply-To: <20260604162805.556135-3-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/06/2026 à 12:28 AM, Vaibhav Jain a écrit :
> Add an example test suite name 'example_test_skip_suite' to
> 'kunit-example-test.c' that shows how to skip an entire test suite based on
> runtime conditions.
> 
> The example suite 'example_skip_suite' provides a 'suite_init' callback
> named example_skip_suite_init() which marks the entire suite as skipped
> using kunit_mark_skipped().
> 
> This demonstrates a way for conditionally skipping test suites when any
> prerequisites for kunit_suite execution are not met. The 'suite_init'
> callback can perform any necessary checks and mark the suite as skipped,
> preventing all test cases from executing while also indicating why the
> suite was skipped.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---

Thanks!

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>  lib/kunit/kunit-example-test.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 0bae7b7ca0b0..b8ded54fa46d 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -591,5 +591,34 @@ static struct kunit_suite example_init_test_suite = {
>   */
>  kunit_test_init_section_suites(&example_init_test_suite);
>  
> +/*
> + * This test should always be skipped.
> + */
> +static void example_skip_suite_test(struct kunit *test)
> +{
> +	/* This line should never be seen */
> +	KUNIT_FAIL(test, "You should not see a this.");
> +}
> +
> +static struct kunit_case  example_skip_suite_test_cases[] = {
> +	KUNIT_CASE(example_skip_suite_test),
> +	{}
> +};
> +
> +static int example_skip_suite_init(struct kunit_suite *suite)
> +{
> +	kunit_mark_skipped(suite, "Test suite expected to be skipped");
> +	return 0;
> +}
> +
> +static struct kunit_suite example_test_skip_suite = {
> +	.name = "example_skip_suite",
> +	.suite_init = example_skip_suite_init,
> +	.test_cases = example_skip_suite_test_cases,
> +};
> +
> +/* This registers a test suite that will be skipped */
> +kunit_test_suite(example_test_skip_suite);
> +
>  MODULE_DESCRIPTION("Example KUnit test suite");
>  MODULE_LICENSE("GPL v2");

