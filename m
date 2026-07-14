Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21194412C04
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051389; cv=none; b=IPdkM/fo/KKqDb7AMDoww4TTdnW/pn13mrX+mcBCV0UCAWaHiF/4yvxtjeu/dfzYdoffCBWXBW2HFXlox/QlJEdNJT9t9rGhL1AsLQsvqkSliYL1bhk9TTHdnQM0N8w9vqRgu9CNbV49IdgJtf5cY5CzWo1sup4dQt0/qYYluFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051389; c=relaxed/simple;
	bh=OIQntFX4xqbdYe6ei2u+RMP51hcSu6LTQr6CtQ9RNBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9LVlcWHjQ53bw13aoPP6kg1rnjTELOBndYuV3S87RqUCm1HUHezp2LjqweuWWhmfZryPlaD3/uRXBI3Ybe8QeO/Qa9Q7YWtY0bLDgRo5xfV7F2NdZIsjT/6S8E8Gb6DWXomwHt+6uzfUucrKzkxgGQG09/m+C4axwKEldyctSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MgRqmF/2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgRqmF/2"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-388b404ea89so1209591a91.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784051373; x=1784656173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iz36X5eBoICtGVtQ+iYEX1d7BS9uTFigjMNx5i3paoA=;
        b=MgRqmF/2PqiY6Reci6q5o7TqErVv0F1xoGgNwIcx4brCeHMjjRziWkQUp5Q2TXwV0X
         Tmli5m05cG0tNCnuymLFWc2pj0bvZBS783zWLXAERdC6KVS9vKu00wbfMzYhT3/FQN5c
         L3dRGducBqVJus4N+v1VMHvWYT0zi47HHn/1Jipv2BDyHcOcJnmx8Z/6aXEG4lZkdYEG
         Fy22cbr/ww/zeqwvW60cVWnAH33hqkbHoqZ30LNsgtbxKxCIGfhybeDQHoYtM/whMkTl
         a4XlZLgPi6YKfE7rhdMr2GP5cj4hGKb3Gz/+vYrNZXlazxetHWG26KFvm4vRzxwbXMYx
         YA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051373; x=1784656173;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iz36X5eBoICtGVtQ+iYEX1d7BS9uTFigjMNx5i3paoA=;
        b=X6fOs5GZBJYi2hi7W6Gj0UR698djEWYJuAHH/qJ7umKIOc+vMTjFwYBQO1bA517uhO
         u1nkKJ3T61LRZ9h1uJE6Ahpa53h3iqeIQFnb5IC9x0pNmtibZyZK09JFOqDfYHKmG/WO
         G79Hej7ZyaoIoujMhdFQfKL1q1OlxTiHkf7Lx9E1+/5AV0KEjFFQFdb6c/oYoeHJHbqz
         nujBN6CHD2lMmVag9Zvlj2g5UsJB0GdCRi71WlFNvd85eJhjsPHTYS7AVO7oMvWQrktm
         7ELwaxuIlFHAKjJ/fVEH9CmBont9pgad09AL7d8lCerAl2CKCklXOJ8Sggn1tGg1wLCE
         YZvg==
X-Gm-Message-State: AOJu0YyixAqKosc+1eyJ4HTos3k0tnimXKIfbtiwbybyIZBXqI2/VrDO
	U/xXnT/chCxF3ytS18cjaC+Ab/UT/d5hCgkAM/V5adaWZUTyHB/HYH/mwo4Aaew0Kw==
X-Gm-Gg: AfdE7cm5LmKpNPoG7/88gCzkWbyi/Clw3MC22Komhuy6pkNpEK/9AVlBaqnhQEIH2cS
	nfirTjEIlzt2PPdeomzDFrG4LvY56aUzlh5bP0KywJPZr7QxU93uhZdG3E0vTp42g/1KJ9CxDKd
	RoRxgSDsmKUEgNlm096b3fmp3yOpnKTUNG3gFh5HUDqzoX1J6I9rWPcW07wcY3WFbVrjD50yD4j
	pwAtH/ZfJpQ35xlGlaqSWT5ofM7pvY/gwOIIEgYOq/hbEENaMvz9ytBL+3GfzON4O/i5zdpJ6f8
	8c6NO3w4TnHdFUwpfxyVGgk4RVSVRrT1h4+pcRmKQTmpigemf07gMAWOQhfdJ6ROE4SezC1f1sm
	17hK9GwS0tul3MGxModyFPNDF4mxUIrgAAIbE8S62swL3FmubBorEva4x+mXe4FfX1QZ8uE9DiN
	Tg2nHf4Q20QPQnsg0ItulPTgHDvbrTWLQpyPGyNfdFFxXx8ACSCKU=
X-Received: by 2002:a17:90b:54cb:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-38d15361ac4mr19394525a91.10.1784051372205;
        Tue, 14 Jul 2026 10:49:32 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e1745a596sm1855015a91.15.2026.07.14.10.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:49:31 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:49:28 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH 3/4] vfio: selftests: Allow a size for
 vfio_dma_mapping_perf_test
Message-ID: <alZ2qLbk_g-NoM5u@google.com>
References: <20260701203311.326798-1-aaronlewis@google.com>
 <20260701203311.326798-4-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701203311.326798-4-aaronlewis@google.com>

On 2026-07-01 08:33 PM, Aaron Lewis wrote:
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
> 
> This invocation configures a 16G DMA region and restricts execution to the
> specified test variant, which is useful when debugging DMA mapping latency
> issues for a specific IOMMU type.
> 
> Signed-off-by: Aaron Lewis <aaronlewis@google.com>
> ---
>  .../vfio/vfio_dma_mapping_perf_test.c         | 132 +++++++++++++++++-
>  1 file changed, 129 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> index 4639bda7ebaa..6c025e9c4420 100644
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
> @@ -19,6 +20,12 @@
>  
>  static const char *device_bdf;
>  
> +struct test_params {
> +	u64 size;
> +};

Move device_bdf into test_params as well.

> +
> +struct test_params test_params;

static

> +
>  struct iommu_mapping {
>  	u64 pgd;
>  	u64 p4d;
> @@ -80,7 +87,7 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
>  
>  TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
>  {
> -	const u64 size = SZ_1G;
> +	const u64 size = test_params.size;
>  	const int flags = variant->mmap_flags;
>  	struct dma_region region;
>  	struct timespec start;
> @@ -204,7 +211,7 @@ static void teardown_memfd(int fd, u64 size, void *vaddr)
>  
>  TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
>  {
> -	const u64 size = SZ_1G;
> +	const u64 size = test_params.size;
>  	struct dma_region region;
>  	struct timespec start;
>  	u64 unmapped;
> @@ -235,8 +242,127 @@ TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
>  	teardown_memfd(fd, size, region.vaddr);
>  }
>  
> +/*
> + * Parses "[0-9]+[kmgt]?".
> + */
> +size_t parse_size(const char *size)

nit: u64 aligns with the types used in the test.

> +{
> +	size_t base;
> +	char *scale;
> +	int shift = 0;
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

I'd like to put this in the library but it's going to conflict with KVM
selftests parse_size() helper when we link libvfio into KVM selftests.

I'd like to unify the common helpers between libvfio and KVM selftests
library but that is future work. In the meantime I guess we can keep
this local.

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

Should this also call test_harness_run(1, "-h") to print its help
message?

> +}
> +
> +struct harness_args
> +{
> +	int argc;
> +	char **argv;
> +	wordexp_t exp;
> +};
> +
> +static void populate_harness_args(struct harness_args *args, const char *argv_0,
> +				  const char *cmdlne)
> +{
> +	if (wordexp(argv_0, &args->exp, WRDE_NOCMD) == 0 &&
> +	    wordexp(cmdlne, &args->exp, WRDE_APPEND | WRDE_NOCMD) == 0) {
> +		args->argc = args->exp.we_wordc;
> +		args->argv = args->exp.we_wordv;
> +	}

Is this missing error handling? Also maybe add some comments since
wordexp() is not a very commonly used helper.

> +}
> +
> +static void setup_test(struct harness_args *args, int argc, char *argv[])
> +{
> +	int opt;
> +
> +	test_params = (struct test_params) {
> +		.size = SZ_1G,
> +	};

Do this where test_params is declared, not here.

  static struct test_params test_params = {
          .size = SZ_1G,
  };

BTW, this change will force all tests to use 1GiB instead of their
current defaults (PAGE_SIZE, 2M, and 1G respectively).

So this change is not purely adding a command line option. I think this
change should probably go into the first commit that introduces the
test, not this one.

> +
> +	while ((opt = getopt(argc, argv, "a:b:h")) != -1) {
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
> +			goto out;

This should exit instead of continuing right?

> +		}
> +	}
> +
> +out:
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
> +	struct harness_args args = (struct harness_args) {
> +		.argc = 0,
> +		.argv = NULL,
> +	};

This can just be:

  struct harness_args args = {};

> +	int r;

Please be consistent about variable names for return codes. There's a
mix of r and rc I've noticed.

> +
> +	setup_test(&args, argc, argv);
>  	device_bdf = vfio_selftests_get_bdf(&argc, argv);

Move this into setup_test() too.

> -	return test_harness_run(argc, argv);
> +	r = test_harness_run(args.argc, args.argv);
> +	teardown_test(&args);
> +
> +	return r;
>  }
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
