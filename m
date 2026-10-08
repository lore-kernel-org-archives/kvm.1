Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6F3B9D9E
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455262; cv=none; b=RK4O2jqFPunw/JWQ0F3LGHhww0+P77X/BgSJxVsi6C0nf3A54YKE8/fw4HS9C8XegxAXDoiisOjC9ux9emmOhQct0GCC+emGsxAHMEHITq/5Cj2ZmYAiAStZTmZrkrptYU+V651pvNKOgJ8G1nOo733TkAwsCqWL7fLQzbEvKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455262; c=relaxed/simple;
	bh=pzV0KGEfnPWlNsLZ6eZNdp6rz39Mcz4Br4ntsTsOTUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA4f3OdturXt2LryWJ1vQ7r6xo3/1ZWf3gOyMaO+EFg+buANVwlafKWeQf88f8HpOIEd9QvaziCt40la95CclXcr5mhNYLe7OEE/lbKpk8iQhEk+gH1daUA0N2wB4ddulJIL2t30fxW6hojRgDyHS8081cpakIFjMdDCVKP92I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLf9IHVL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLf9IHVL"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so2290834a12.2
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 03:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791455260; x=1792060060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0UCVwsFbfHG4fUQmCEChejx1MkBmDCHujMtoBrNi4SU=;
        b=nLf9IHVLwVBDev9RGYhfjmKYZZv8k2EG07MKTJEQQgAiwRUfNP8J3CbWXSyd8jrIoM
         l0m7pnWidRpWBOgvHZII4U1xHV6jOBO1/CldPHTJvoD6RIrihwym7S8B80jGO/V2/GDu
         1xFLjWlc2ZyiIUNKWUyZ5VM2zwobCIIiEw7Yrs/odK0O+YpqoJQaeC18oEXWclJUemVK
         D0u2aMaj8yRFZ3qyl/UI1O8JnQMEKDGWYfQCnwtr8T9WehYl/UviVXMimqPlOs5ajPYd
         VQDz26OFaApGPoLE2x5tC37sokLKGDPTBDDp/vy60TDnvKs5vT3kEEw4W7Nw23LeI8zD
         4YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455260; x=1792060060;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0UCVwsFbfHG4fUQmCEChejx1MkBmDCHujMtoBrNi4SU=;
        b=mKDzHUOgTypx1Uw1He4CZ8uGni0/cgsozHi1072tYP8/W/SkPZQLtGh6i8ZMOpACUf
         tAjZM9iUekczyuJd8mqsI7NmwvWWxx+QpMBOoYK9RZb9cuh2JlX924zUeEIBZhRIrbRJ
         tgThaX0LpBpzHxli07nJ//v6oqlwh2Bo5FniLO7svuvXQT1yRZmQcb8Zek8kZ9YyNVt7
         unmqB5xiQxKZi7saApInxyT25Py47yk/xwKHhP4yPpGycqLrI6ln2+HupA6WU18ZftFg
         gHWz1YlHBjg9Q03u7w2bAaPEuc+/D1Ymd6yqZRGakoIEas3QumD1gMnYlyaaoMNfhfQi
         9z4w==
X-Gm-Message-State: AFq9FYKSNRmhv0h0sOZurgUkMNEJj/iw53kdcGWfOFzZCme2rWI2hTmW
	JHoLOGaFTcUPxfgkaFQIQuSZQBpkNqv3D7lCFBDE/U1pprROIICaNHkWgXueJ+9fN6diuCWKSvi
	V6whY4Q==
X-Gm-Gg: AYBFou3nyB/v12C4w3yOJZLKDfqxSVRBSFlIWq5EysRyYhthR3v+m2JebfAamHk/7NP
	bsKWXVS5+nbd2/qxbzbwBVOgZ4FiV4bL+Z8WqCM4zy7R/D6xN7PnbmIgUZ+Lk/YHqX7rfdm7c6/
	Rov7sGRp7Do/5JDxENDkZ4bKjKUwLop0rwCe44iu0wyZJ/YwszcsMlxt7W0Wncxnpb9qPzQiyS6
	k7R3jm/piey1WSfPtgd0QHeTX2o6WlLNTLLTlNnPKPQOWzdHNAFxobM1wBOS9Jx7jV5MCzikrYW
	NVZPgpalBXzKwTn4dy6C5JiHJb267on60mUQfBPDnojEqSh/fpBW68jWqoDSoGCA2LoN/N7pSs5
	oNGu3ZN8yBmAtO0WZqLZ8h7q80IL4g2CB2i0ZwyNDawIgFuOOkb83cDr8n/1+flxdRh7F15n6Lv
	amumVUji2HhBtgBL7nvl4Y5NovN4iJrIAA+ZLTFVytcd43zah1RfkwdUlbkQ8kF1w/+4ZanfPyE
	rzmD9qAloUwUROgcQwBFrLAguV+pIoGWNM=
X-Received: by 2002:a17:90b:3148:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3a8a1abf904mr4348992a91.24.1791455259695;
        Thu, 08 Oct 2026 03:27:39 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aaee881786sm1459203a91.0.2026.10.08.03.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:27:37 -0700 (PDT)
Date: Thu, 8 Oct 2026 10:27:33 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH v3 4/4] vfio: selftests: Allow a size for
 vfio_dma_mapping_perf_test
Message-ID: <asdwFZdtp4Tqj82p@google.com>
References: <20260910153326.3085937-1-aaronlewis@google.com>
 <20260910153326.3085937-5-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910153326.3085937-5-aaronlewis@google.com>

On 2026-09-10 03:33 PM, Aaron Lewis wrote:
> Allow the user to specify a DMA region size via the command line for
> vfio_dma_mapping_perf_test.
> 
> Because the selftest harness parses command-line parameters, adding
> custom options directly to individual tests requires the test harness
> to recognize them.
> 
> Add support to kselftest_harness.h for custom command-line options via
> struct test_harness_cli_opts and test_harness_run_opts(). Then use this
> interface in vfio_dma_mapping_perf_test to introduce a new '-b' option to
> specify the DMA region size.
> 
> For example, both the test size and test harness options can now be
> passed together naturally:
> 
>   ./vfio_dma_mapping_perf_test -b 16G -v vfio_type1_iommu_memfd_hugetlb_1gb
> 
> Assert if the custom options string is problematic (e.g. conflicting with
> built-in options or exceeding the buffer limit). This should only happen
> when developing a test, and asserting makes the issue immediately obvious
> to the developer.
> 
> Signed-off-by: Aaron Lewis <aaronlewis@google.com>
> ---
>  tools/testing/selftests/kselftest_harness.h   | 86 ++++++++++++++++---

Please split out the kselftest_harness.h change into its own commit. We
need to get that commit acked by the selftests maintainers.

>  .../vfio/vfio_dma_mapping_perf_test.c         | 86 +++++++++++++++++--
>  2 files changed, 151 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 29a19bc87084..5065eb7144bc 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -54,6 +54,7 @@
>  #define _GNU_SOURCE
>  #endif
>  #include <asm/types.h>
> +#include <assert.h>
>  #include <ctype.h>
>  #include <errno.h>
>  #include <linux/unistd.h>
> @@ -76,6 +77,18 @@ static inline void __kselftest_memset_safe(void *s, int c, size_t n)
>  		memset(s, c, n);
>  }
>  
> +/**
> + * struct test_harness_cli_opts - Custom command-line options for test harness
> + * @optstring: getopt option string; must not conflict with harness options.
> + * @handler: Callback to handle custom options; returns KSFT_PASS or KSFT_FAIL.
> + * @help: Optional callback to print custom option help text.
> + */
> +struct test_harness_cli_opts {
> +	const char *optstring;
> +	int (*handler)(int opt, char *optarg);
> +	void (*help)(void);
> +};
> +
>  #define KSELFTEST_PRIO_TEST    20000
>  #define KSELFTEST_PRIO_XFAIL   20001
>  
> @@ -1097,11 +1110,36 @@ static void test_harness_list_tests(void)
>  	}
>  }
>  
> -static int test_harness_argv_check(int argc, char **argv)
> +#define OPTSTRING_LEN 128
> +
> +static void optstring_append_custom(char *optstring, size_t size,
> +				    const struct test_harness_cli_opts *opts)
>  {
> +	const char *c;
> +
> +	if (!opts || !opts->optstring)
> +		return;
> +
> +	assert(strlen(optstring) + strlen(opts->optstring) < size);
> +
> +	for (c = opts->optstring; *c; c++) {
> +		if (isalnum(*c))
> +			assert(!strchr(optstring, *c));
> +	}
> +
> +	strncat(optstring, opts->optstring, size - strlen(optstring) - 1);
> +}
> +
> +static int test_harness_argv_check(int argc, char **argv,
> +				   const struct test_harness_cli_opts *opts)
> +{
> +	char optstring[OPTSTRING_LEN] = "dhlF:f:V:v:t:T:r:";
>  	int opt;
>  
> -	while ((opt = getopt(argc, argv, "dhlF:f:V:v:t:T:r:")) != -1) {
> +	optstring_append_custom(optstring, sizeof(optstring), opts);
> +
> +	optind = 1;
> +	while ((opt = getopt(argc, argv, optstring)) != -1) {
>  		switch (opt) {
>  		case 'f':
>  		case 'F':
> @@ -1118,7 +1156,6 @@ static int test_harness_argv_check(int argc, char **argv)
>  			ksft_debug_enabled = true;
>  			break;
>  		case 'h':
> -		default:
>  			fprintf(stderr,
>  				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name]\n"
>  				"\t-h       print help\n"
> @@ -1139,7 +1176,14 @@ static int test_harness_argv_check(int argc, char **argv)
>  				"include all tests from variant 'bla'\n"
>  				"but not test 'foo' specify '-T foo -v bla'.\n"
>  				"", argv[0]);
> -			return opt == 'h' ? KSFT_SKIP : KSFT_FAIL;
> +			if (opts && opts->help)
> +				opts->help();
> +			return KSFT_SKIP;
> +		default:
> +			if (opts && opts->handler &&
> +			    opts->handler(opt, optarg) == KSFT_PASS)
> +				break;

If this fails it should still print the help message to match the
previous behavior.

> +			return KSFT_FAIL;
>  		}
>  	}
>  
> @@ -1149,31 +1193,39 @@ static int test_harness_argv_check(int argc, char **argv)
>  static bool test_enabled(int argc, char **argv,
>  			 struct __fixture_metadata *f,
>  			 struct __fixture_variant_metadata *v,
> -			 struct __test_metadata *t)
> +			 struct __test_metadata *t,
> +			 const struct test_harness_cli_opts *opts)
>  {
>  	unsigned int flen = 0, vlen = 0, tlen = 0;
> +	char optstring[OPTSTRING_LEN] = "dF:f:V:v:t:T:r:";
>  	bool has_positive = false;
>  	int opt;
>  
> -	optind = 1;
> -	while ((opt = getopt(argc, argv, "dF:f:V:v:t:T:r:")) != -1) {
> -		if (opt != 'd')
> -			has_positive |= islower(opt);
> +	optstring_append_custom(optstring, sizeof(optstring), opts);

Can the full optstring be constructed once and then passed into
test_enabled()? That would also eliminate the duplicate hard-coded
opt-string.

>  
> -		switch (tolower(opt)) {
> +	optind = 1;
> +	while ((opt = getopt(argc, argv, optstring)) != -1) {
> +		switch (opt) {
>  		case 't':
> +		case 'T':
> +			has_positive |= islower(opt);
>  			if (!strcmp(t->name, optarg))
>  				return islower(opt);
>  			break;
>  		case 'f':
> +		case 'F':
> +			has_positive |= islower(opt);
>  			if (!strcmp(f->name, optarg))
>  				return islower(opt);
>  			break;
>  		case 'v':
> +		case 'V':
> +			has_positive |= islower(opt);
>  			if (!strcmp(v->name, optarg))
>  				return islower(opt);
>  			break;
>  		case 'r':
> +			has_positive = true;
>  			if (!tlen) {
>  				flen = strlen(f->name);
>  				vlen = strlen(v->name);
> @@ -1262,7 +1314,8 @@ static void __run_test(struct __fixture_metadata *f,
>  			      diagnostic ? "%s" : NULL, diagnostic);
>  }
>  
> -static int test_harness_run(int argc, char **argv)
> +static int test_harness_run_opts(int argc, char **argv,
> +				 const struct test_harness_cli_opts *opts)
>  {
>  	struct __fixture_variant_metadata no_variant = { .name = "", };
>  	struct __fixture_variant_metadata *v;
> @@ -1274,7 +1327,7 @@ static int test_harness_run(int argc, char **argv)
>  	unsigned int count = 0;
>  	unsigned int pass_count = 0;
>  
> -	ret = test_harness_argv_check(argc, argv);
> +	ret = test_harness_argv_check(argc, argv, opts);
>  	if (ret != KSFT_PASS)
>  		return ret;
>  
> @@ -1283,7 +1336,7 @@ static int test_harness_run(int argc, char **argv)
>  			unsigned int old_tests = test_count;
>  
>  			for (t = f->tests; t; t = t->next)
> -				if (test_enabled(argc, argv, f, v, t))
> +				if (test_enabled(argc, argv, f, v, t, opts))
>  					test_count++;
>  
>  			if (old_tests != test_count)
> @@ -1301,7 +1354,7 @@ static int test_harness_run(int argc, char **argv)
>  	for (f = __fixture_list; f; f = f->next) {
>  		for (v = f->variant ?: &no_variant; v; v = v->next) {
>  			for (t = f->tests; t; t = t->next) {
> -				if (!test_enabled(argc, argv, f, v, t))
> +				if (!test_enabled(argc, argv, f, v, t, opts))
>  					continue;
>  				count++;
>  				t->results = results;
> @@ -1324,6 +1377,11 @@ static int test_harness_run(int argc, char **argv)
>  	return KSFT_FAIL;
>  }
>  
> +static inline int test_harness_run(int argc, char **argv)
> +{
> +	return test_harness_run_opts(argc, argv, NULL);
> +}
> +
>  static void __attribute__((constructor(KSELFTEST_PRIO_TEST))) __constructor_order_first(void)
>  {
>  	__constructor_order_forward = true;
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> index 4113a20127de..84a973a53b8c 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <ctype.h>
>  #include <limits.h>
>  #include <stdio.h>
>  #include <sys/mman.h>
> @@ -17,7 +18,78 @@
>  
>  #include "kselftest_harness.h"
>  
> -static const char *device_bdf;
> +static struct {
> +	u64 size;
> +	const char *device_bdf;
> +} test_params = {
> +	.size = SZ_1G,
> +};
> +
> +/*
> + * Parses "[0-9]+[kmgt]?".
> + */
> +static u64 parse_size(const char *size)
> +{
> +	int shift = 0;
> +	char *scale;
> +	u64 base;
> +
> +	VFIO_ASSERT_TRUE(size && isdigit(size[0]),
> +			 "Need at least one digit in '%s'.", size);
> +
> +	base = strtoull(size, &scale, 0);
> +
> +	VFIO_ASSERT_TRUE(base != ULLONG_MAX, "Overflow parsing size!");
> +
> +	switch (tolower(*scale)) {
> +	case 't':
> +		shift = 40;
> +		break;
> +	case 'g':
> +		shift = 30;
> +		break;
> +	case 'm':
> +		shift = 20;
> +		break;
> +	case 'k':
> +		shift = 10;
> +		break;
> +	case 'b':
> +	case '\0':
> +		shift = 0;
> +		break;
> +	default:
> +		VFIO_FAIL("Unknown size letter '%c'.", *scale);
> +	}
> +
> +	VFIO_ASSERT_TRUE((base << shift) >> shift == base,
> +			 "Overflow scaling size!");
> +
> +	return base << shift;
> +}
> +
> +static void opt_custom_help(void)
> +{
> +	fprintf(stderr,
> +		"\nCustom options:\n"

It shouldn't be on every test to print a header and leading newline like
this for their custom options. kselftest_harness.h should provide this.

e.g.

  if (opts && opts->help) {
          fprintf(stderr, "\nCustom options:\n");
	  ops->help();
  }

> +		"\t-b bytes Specify the size of the DMA region to be mapped\n"
> +		"\t         and unmapped. e.g. 16M or 8G, (default: 1G)\n");
> +}
> +
> +static int opt_custom_handler(int opt, char *optarg)
> +{
> +	if (opt == 'b') {
> +		test_params.size = parse_size(optarg);
> +		return KSFT_PASS;
> +	}
> +	return KSFT_FAIL;
> +}
> +
> +static const struct test_harness_cli_opts opts = {
> +	.optstring = "b:",
> +	.handler = opt_custom_handler,
> +	.help = opt_custom_help,

nit: "custom" seems unnecessary. And to align the naming it should be
opts not opt.

> +};
>  
>  FIXTURE(vfio_dma_mapping_perf_test) {
>  	struct iommu *iommu;
> @@ -45,7 +117,7 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, MAP_HUGETLB | MAP_HUG
>  FIXTURE_SETUP(vfio_dma_mapping_perf_test)
>  {
>  	self->iommu = iommu_init(variant->iommu_mode);
> -	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +	self->device = vfio_pci_device_init(test_params.device_bdf, self->iommu);
>  	self->iova_allocator = iova_allocator_init(self->iommu);
>  }
>  
> @@ -58,7 +130,7 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
>  
>  TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
>  {
> -	const u64 size = SZ_1G;
> +	const u64 size = test_params.size;
>  	const int flags = variant->mmap_flags;
>  	struct dma_region region;
>  
> @@ -115,7 +187,7 @@ FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_1gb,
>  FIXTURE_SETUP(vfio_dma_mapping_perf_memfd_test)
>  {
>  	self->iommu = iommu_init(variant->iommu_mode);
> -	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +	self->device = vfio_pci_device_init(test_params.device_bdf, self->iommu);
>  	self->iova_allocator = iova_allocator_init(self->iommu);
>  }
>  
> @@ -156,7 +228,7 @@ static void teardown_memfd(int fd, u64 size, void *vaddr)
>  
>  TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
>  {
> -	const u64 size = SZ_1G;
> +	const u64 size = test_params.size;
>  	const int mmap_flags = variant->mmap_flags;
>  	struct dma_region region;
>  	int fd;
> @@ -186,6 +258,6 @@ TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
>  
>  int main(int argc, char *argv[])
>  {
> -	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> -	return test_harness_run(argc, argv);
> +	test_params.device_bdf = vfio_selftests_get_bdf(&argc, argv);
> +	return test_harness_run_opts(argc, argv, &opts);
>  }
> -- 
> 2.55.0.1003.g10538fe699-goog
> 
