Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286DB3655FA
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747087; cv=none; b=bmEPuCqv4uTjEjtSCt/53j4QiiXWRC5CNV72/ehzgqMUHhrrnpZ0d0HXYcRWmH/FZPHk/wNkAtcYK2I0F+F/SaYPMmtOqtTdrll1bzprzCBNK/gRh45n2G4imSphvyV82v0d6yljl9MzJrQ28NxOZ5aUHkLwqN9xhy00xZefhK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747087; c=relaxed/simple;
	bh=MVl6e7TWu5n/rWliXmwAB5C+9kHukL00XfG1mML9xF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ownkzA+cyNrgInc0qkiniqojboUxSjzUg4K78vRWnmEH48NHlBXJQrHzqikbpFklJPGFwIflfxcizT6xx1E5lreM9R9C0Zfye4ewRk4cueWHLv/IDJipQ4jwak9BK5ZrBArwcrzRFwVkDPtVytvQ20AzSKtoRsSNf6UjTFuuhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlQZQHb8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlQZQHb8"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8485ef63b68so1220495b3a.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 15:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786747085; x=1787351885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CPYoXlQLa9cb/zBr4H0XgoMSmy+mWin+YeKrV4UQeaU=;
        b=BlQZQHb8RepoIm9DhGkwwy6EUXbrJt1pfXHCArj7/C0rae/wqTTFXOztXrBXprOGF2
         xSQo/r/pXWjMZot8T91OdH8z+GZ5qBVvQrkBMFO83tGTJOqFByu6ubI6f1eF5NsPBc4O
         Ls1x/XGEOjwFRyk9Q9gK6YXaIJv7xXSpBmZFN6f7++vkVBfhu6dmRvpWwOqOiALYrZpO
         wKWwnPSskIu6Q0oCLtFk/nQ6++M5dTqprPZDNYBOpI/nV34sYJyrIjUPLafAF6RS/Zse
         O7VPF+8gSsSWcxPf9PwKEeEZw8MQJZQL7o6jbmFxle6YEPsR2HMSo6ZZtTmZRL5W7Xfe
         j8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786747085; x=1787351885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPYoXlQLa9cb/zBr4H0XgoMSmy+mWin+YeKrV4UQeaU=;
        b=QmfyrL2vUSx1YyYsP+mF72+gMfGSLn0bYEiEEnWaRlLV9NJXh/9T092rA8vh5ITWXw
         3CnN8ZbVx3qRttK8a9J3BI1n0MeI7EhTj9S00SZY9eyLzbW1SKJY2iSs6K6S24SuyfYl
         SxIdFeZHPzeDxP9gnGYRSUM5WuvLpjYYlegDI4sjVmyB9B74RZmB2xgR45+3jQU7qx0V
         QucsL0Cl3PxJOgGHcEh3X1J5i028GGb1LjWlh1pqy3F4o0l6M83eVpimcIYJhfqGvLD1
         aEWQmkhblm9OjUV5y4NjjhMU0IPczDc9tOYif+UZ2zNfv2j8yHH0iSEJcnEt/0k5ih5V
         tsAQ==
X-Gm-Message-State: AOJu0YwIPOfsJlOmFZboFXDCQKa1UlSt2lCt9DyQ+s8V8/nO0cECiLWl
	2K4gbQuuXPQU9UtlLKei1tQOHxL9QbQfmfw2eGizIDjzXxEZeUW8STMF8K9cNEeG2g==
X-Gm-Gg: AR+sD12vD3VkR0+fO3ayEuThzhV26r02U0U/DxksWqFIg6IOm+TpNEzaCaA/qg3CASs
	qias0G+4qukPO4FX3jVJh1YlMeGpk+5Xq66YxRdNEuAkDsP3RzV9x/KFBWilN1cnwL9GyetI7k8
	bQABHXvBunN8N2GG5DNhY8ORoG/W2SL/tUaLPJXVAfpNrIQg9v7lfJGcrsud1gAs7tFHN5pOFNH
	AOj1PYqghcolHkmqe29D/HXsZaz1bRdYgJ7UpHrhVPYdCWyAcPTtV8xVgnybFZ7S5pCW+gIDK69
	vTyrfPdkgTrksm8HTb3ROD59LFGUcsOzZFGHM5GTGZL4GqlkwP2fCr49P7njw0zzH/mFywOng30
	00OLaaCNY2bgqhRgM6DXqozyCuheTc3qfdDan8n+QyYTjsu7GknKJkSPVaY7RDD0WsbqpJJ/hdZ
	RNxF9wHVYKfiE8RrlevpbZMHGQqL4CwXeWObSjQi9gUeWP5SJgnWHtPVNHzt4+sBbVU13pUYwd5
	bCdxQwbJyMWwO7EkrUFfPgvFFagvA==
X-Received: by 2002:a05:6a00:a21b:b0:848:417a:d1a6 with SMTP id d2e1a72fcca58-84fddfec0e9mr9695576b3a.15.1786747084730;
        Fri, 14 Aug 2026 15:38:04 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223d97sm973133b3a.28.2026.08.14.15.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:38:04 -0700 (PDT)
Date: Fri, 14 Aug 2026 22:38:01 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH v2 4/4] vfio: selftests: Allow a size for
 vfio_dma_mapping_perf_test
Message-ID: <an-YyQV-CtoulEHr@google.com>
References: <20260804165748.1060476-1-aaronlewis@google.com>
 <20260804165748.1060476-5-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804165748.1060476-5-aaronlewis@google.com>

On 2026-08-04 04:57 PM, Aaron Lewis wrote:
> Allow the user to specify a DMA region size via the command line for
> vfio_dma_mapping_perf_test.
> 
> Because the selftest harness also parses command-line parameters, sharing
> them directly is problematic. Adding options directly to the test could
> create conflicts with harness-defined options. Even without conflicts, the
> harness would need to be updated to recognize test-specific options to avoid
> failing on unknown parameters.
> 
> Resolve this by isolating the two sets of parameters. The standard command-line
> options are consumed by the test itself. To pass options through to the test
> harness, introduce a new '-a' option.
> 
> For example, both the test size and the test harness options can be set
> like this:
> 
> ./vfio_dma_mapping_perf_test -b 16G -a "-v vfio_type1_iommu_memfd_hugetlb_1gb"

I tried this out and it's a little clunky to work with. Especially -h.
Plus it's quite a bit of code in the test to deal with the different
argv arrays and parse everything...

Here are the other options I think we should consider:

 1. Abandon the kselftest_harness for this test and manually replicate
    across the different IOMMU modes and memory types. I don't love this
    since it will differ from other VFIO selftests, we'll need to
    reinvent the test fixture replication, and we lose the TAP output.

 2. Add first-class support to kselftest_harness for custom test
    arguments. I ran it through Gemini and it came up with something
    relatively clean [1].

 3. Just use an environment variable for this one argument. This would
    be extremely simple to implement and use.

 4. Have the test look up how many HugeTLB pages are free on the system
    and just use all of them. You can control how much memory the test
    uses by controlling how many HugeTLB pages are allocated on the
    system.

What are your thoughts?

[1]
  In kselftest_harness.h:

    #ifndef OPT_CUSTOM_STR
    # define OPT_CUSTOM_STR ""
    # define OPT_CUSTOM_HANDLER(opt, optarg) KSFT_FAIL
    # define OPT_CUSTOM_HELP()
    #endif

    // Modify test_harness_argv_check()
    static int test_harness_argv_check(int argc, char **argv)
    {
        int opt;
        char optstring[128] = "dhlF:f:V:v:t:T:r:";
        // Safely append OPT_CUSTOM_STR to optstring
        strncat(optstring, OPT_CUSTOM_STR, sizeof(optstring) - strlen(optstring) - 1);

        while ((opt = getopt(argc, argv, optstring)) != -1) {
            switch (opt) {
                /* ... existing core cases ... */
                case 'h':
                    fprintf(stderr, "Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name]\n...", argv[0]);
                    OPT_CUSTOM_HELP();
                    return KSFT_SKIP;

                default:
                    if (OPT_CUSTOM_HANDLER(opt, optarg) == KSFT_PASS)
    			break;
                    return KSFT_FAIL;
            }
        }
        return KSFT_PASS;
    }

  In vfio_dma_mapping_perf_test.c (before #include "kselftest_harness.h"):

    static void opt_custom_help(void) {
        fprintf(stderr, "\t-b bytes Specify the size of the DMA region...\n");
    }

    static int opt_custom_handler(int opt, char *optarg) {
        if (opt == 'b') {
            test_params.size = parse_size(optarg);
            return KSFT_PASS;
        }
        return KSFT_FAIL;
    }

    #define OPT_CUSTOM_STR "b:"
    #define OPT_CUSTOM_HANDLER(opt, optarg) opt_custom_handler(opt, optarg)
    #define OPT_CUSTOM_HELP() opt_custom_help()

    #include "kselftest_harness.h"


> This invocation configures a 16G DMA region and restricts execution to the
> specified test variant, which is useful when debugging DMA mapping latency
> issues for a specific IOMMU type.
> 
> Signed-off-by: Aaron Lewis <aaronlewis@google.com>
> ---
>  .../vfio/vfio_dma_mapping_perf_test.c         | 159 ++++++++++++++++--
>  1 file changed, 149 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> index 5ef85deba4ee..af2273a0c6f5 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> @@ -4,6 +4,7 @@
>  #include <sys/mman.h>
>  #include <time.h>
>  #include <unistd.h>
> +#include <wordexp.h>
>  
>  #include <linux/iommufd.h>
>  #include <linux/limits.h>
> @@ -17,7 +18,12 @@
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
>  
>  FIXTURE(vfio_dma_mapping_perf_test) {
>  	struct iommu *iommu;
> @@ -45,7 +51,7 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, MAP_HUGETLB | MAP_HUG
>  FIXTURE_SETUP(vfio_dma_mapping_perf_test)
>  {
>  	self->iommu = iommu_init(variant->iommu_mode);
> -	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +	self->device = vfio_pci_device_init(test_params.device_bdf, self->iommu);
>  	self->iova_allocator = iova_allocator_init(self->iommu);
>  }
>  
> @@ -58,7 +64,7 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
>  
>  TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
>  {
> -	const u64 size = SZ_1G;
> +	const u64 size = test_params.size;
>  	const int flags = variant->mmap_flags;
>  	struct dma_region region;
>  
> @@ -115,7 +121,7 @@ FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_1gb,
>  FIXTURE_SETUP(vfio_dma_mapping_perf_memfd_test)
>  {
>  	self->iommu = iommu_init(variant->iommu_mode);
> -	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +	self->device = vfio_pci_device_init(test_params.device_bdf, self->iommu);
>  	self->iova_allocator = iova_allocator_init(self->iommu);
>  }
>  
> @@ -159,17 +165,17 @@ static void teardown_memfd(int fd, u64 size, void *vaddr)
>  
>  TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
>  {
> -	const u64 size = SZ_1G;
> -	const int flags = variant->mmap_flags;
> +	const u64 size = test_params.size;
> +	const int mmap_flags = variant->mmap_flags;
>  	struct dma_region region;
>  	int fd;
>  
>  	printf("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
>  
> -	region.vaddr = setup_memfd(&fd, size, variant->mmap_flags, variant->memfd_flags);
> +	region.vaddr = setup_memfd(&fd, size, mmap_flags, variant->memfd_flags);
>  
>  	/* Skip the test if there aren't enough HugeTLB pages available. */
> -	if (flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
> +	if (mmap_flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
>  		SKIP(return, "setup_memfd() failed: %s (%d)\n", strerror(errno), errno);
>  	else
>  		ASSERT_NE(region.vaddr, MAP_FAILED);
> @@ -185,8 +191,141 @@ TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
>  	teardown_memfd(fd, size, region.vaddr);
>  }
>  
> +/*
> + * Parses "[0-9]+[kmgt]?".
> + */
> +u64 parse_size(const char *size)
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
> +static void help(char *name)
> +{
> +	puts("");
> +	printf("usage: %s [-h] [-b bytes] [-a \"test harness args\"]\n", name);
> +	puts("");
> +	printf(" -h: Display this help message.\n"
> +	       " -b: Specify the size of the DMA region to be mapped\n"
> +	       "     and unmapped. e.g. 16M or 8G, (default: 1G)\n"
> +	       " -a: Args that are forwarded to the test harness,\n"
> +	       "     e.g. -a \"-t dma_map_unmap_from_file\"\n");

This should be printed to stderr so that this and the kselftest_harness
help message get printed to the same place.

Also the -h output is pretty confusing because it just has the 2 usage
logs one after another:

  usage: tools/testing/selftests/vfio_dma_mapping_perf_test ...
  ...

  Usage: tools/testing/selftests/vfio_dma_mapping_perf_test ...
  ...

Some extra logging to help the user understand would be needed.

> +}
> +
> +struct harness_args {
> +	int argc;
> +	char **argv;
> +	wordexp_t exp;
> +};
> +
> +static void populate_harness_args(struct harness_args *args, const char *argv_0,
> +				  const char *cmdlne)
> +{
> +	int flags = WRDE_NOCMD;
> +
> +	if (!args->argv) {
> +		/*
> +		 * Initialize the argument list with the program name (argv[0]).
> +		 * WRDE_NOCMD disables command substitution for safety.
> +		 */
> +		if (wordexp(argv_0, &args->exp, flags) != 0)
> +			VFIO_FAIL("Failed to evaluate test harness argv_0 args!");
> +	}
> +
> +	flags |= WRDE_APPEND;
> +
> +	/*
> +	 * Use wordexp() to reliably parse the user-supplied command line string
> +	 * into individual arguments, respecting shell quoting and escaping rules.
> +	 * WRDE_APPEND merges these new arguments with the earlier argv[0].
> +	 */
> +	if (wordexp(cmdlne, &args->exp, flags) != 0)
> +		VFIO_FAIL("Failed to evaluate test harness cmdlne args!");
> +
> +	args->argc = args->exp.we_wordc;
> +	args->argv = args->exp.we_wordv;
> +}
> +
> +static void setup_test(struct harness_args *args, int *argc, char *argv[])
> +{
> +	char *h_argv[] = { argv[0], "-h" };
> +	int opt;
> +
> +	test_params.device_bdf = vfio_selftests_get_bdf(argc, argv);
> +
> +	while ((opt = getopt(*argc, argv, "a:b:h")) != -1) {
> +		switch (opt) {
> +		case 'a':
> +			populate_harness_args(args, argv[0], optarg);
> +			break;
> +		case 'b':
> +			test_params.size = parse_size(optarg);
> +			break;
> +		case 'h':
> +		default:
> +			help(argv[0]);
> +			exit(test_harness_run(2, h_argv));

Need to reset optind to 1 before calling test_harness_run(). Also maybe
this should just call test_harness_argv_check()?

> +		}
> +	}
> +
> +	// Reset getopt() state to allow the test harness to use it.
> +	optind = 1;
> +}
> +
> +static void teardown_test(struct harness_args *args)
> +{
> +	if (args->argv) {
> +		args->argc = 0;
> +		args->argv = NULL;
> +		wordfree(&args->exp);
> +	}
> +}
> +
>  int main(int argc, char *argv[])
>  {
> -	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> -	return test_harness_run(argc, argv);
> +	char *default_hargs[] = { argv[0], NULL };
> +	struct harness_args args = {};
> +	int r;
> +
> +	setup_test(&args, &argc, argv);
> +
> +	r = test_harness_run(args.argc ?: 1, args.argv ?: default_hargs);
> +
> +	teardown_test(&args);
> +
> +	return r;
>  }
> -- 
> 2.55.0.654.g21b8a5bc05-goog
> 
