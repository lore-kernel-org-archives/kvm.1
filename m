Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FF93B52EB
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532800; cv=none; b=t1I9Dx6BzaUeRVNw9GvlhKpZ4xmYGjIEhenEa/Q+hzb5oyCmPU7YH2rmcgA9g2+EuiH3gtPlw+wj5u1BLWLgDyw/kFFZOUV19BIItLnAp1d31TLmwFq0PN2u/ZM4vDW5hjwO2ZI4j8NCC2ABHMtN1c0kHgnt4nCJqBTZuQbPf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532800; c=relaxed/simple;
	bh=Km++bgstJy22aPuoAl4fC3UyjcfdgbFAcUcT6xfJrcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZXb8rchUc30knH6CgO6HaT6F1R9ivi65rSXIQRTqz5dUaGA0pYbdya2H9eg4jgYvDZpslYa1dItOqaZ/A+AoWgw7Rp6poUlQEJHBEU5AnIrGT2Bt7CnqXvjRGDaungZTpD+mtUI2ZWceK6/WXIP4uDGBsmZX65uBlqKQHvdL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SsNyo+qD; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsNyo+qD"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-132cccd3d77so268c88.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778532797; x=1779137597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10PxtWyhgedi2BJxlEdo5PBTQQ1UNrd1U0mb5g7f0RA=;
        b=SsNyo+qD6cU8mcfN5wwC8wMRe+4aG5EQKB6JU5aNkpy6FK9Au/IxzC7v9C/lL50p/D
         iVUuDBjzJPdqkQAIJaMqmh78P/Sid9XOOvSwDrHeBBwD/l4s9C9ce/iNOma2Ag3tG3oK
         TFtP4Skry3C8dz+OT9OEnKufTkheoLzoW+aYsZEeMclEN2s3gD0bBzZaFefCtRwL0UEX
         YdHw6sUqsMsFTVPW5BTUs99HHdThwDNKEgoLUPyN7j/RDc7fRcl8A8c6dd7Mmw10G0RL
         oAlD36zBfh186DykIvr8Q1c1zCmyKN2RypLteHIhMkSRCL9VmChXNZTuyqqgCHRU1HrC
         ET0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778532797; x=1779137597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10PxtWyhgedi2BJxlEdo5PBTQQ1UNrd1U0mb5g7f0RA=;
        b=Fs8OgVkMUqgMPfoEaHcbCw7Cta8U9gsB9XWkHxPE1OUF+P1VLOqiw86m+JFg3T26Jw
         8UsD+v7YNbqlDz8pcRbvtMWFqeU0DpeOuA5kSdklxclWMkGMFaXUk4HFbp6gC62g8P3I
         UBWc3P1LF8uPxFRw5iwSV0eut8JhJyFeTnDeQWbCRrXi+jRi4ZzAnwjvUN9AtG0/Bl4s
         WwuBLHVu/ZncgKTKac9Lbc2rHLOLHd5PcH/fy7vyyWdnoiQqxNLj/GTgfNEX9JHFrlNE
         cUzgNvFznYSNeu0jkz6htT/a3yrcyKAgXiT0ZbMLBaXpBppG7Z1rERpTFrUEWqAtO8Qx
         DXPw==
X-Forwarded-Encrypted: i=1; AFNElJ98XP1H+ufAb2SNqbW4hixviBhH1bTQzRhOKdPrkBwvln1n/akfTXgeJlADMGYgfVRedKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyea0/o5QBkSUPEXGoGfPRoqkEM8Fi2Thl2cDvMDa8Bg46xv6ON
	eJt6Tg1Fm6jYRhSGPiS1Wougw8euW6Bvw/VpT6fbSGeb1NGC4MNUrb4tk45nS9pQ2Q==
X-Gm-Gg: Acq92OEwafUrEreK5s6de3VCKYkXa11OLHnAAFiXce+WJNlXUN+sm40itg29/FEuPNS
	pEcghyC0Bq+j9UVi2aDfDhrnoEFWy7Km6khrdb+TE85dOdij5rQPqb5uvizI6tJY73W8rMoUtst
	gHuQkdNFODHIWVHGCUSuujzlYsRmunzpnfj6E07xR6uBIa6/PcsOB2oWXZZNdvNAK0Vw5R4dWQU
	O5rFgXbiIigpC7p/r6h6Wo8vMFoANBammssuSwrTCDLQUgvMs4PFGlTl9hL8bDOwwqs4/7AIxiD
	1Ip4oagv9n/aYYtmUA7PmWFCkLWeDq79637Gj71C1Tob9R01kA3FgwxGcECoE9rAQE9TCsNJpzr
	ySLBYtoyDlT1+70NWhAcVaQwoMufk3JLE5SwMAaikORzkvttCpylj9yBGUsLM80bBxp/OmOnMvx
	bXfXKgKdq6AfvvuRCzpWy1K1wxV+NyUJafCJgWMRAAurP9BGsMboPNKLU/br7sW0nea1FsPA==
X-Received: by 2002:a05:7022:fd09:b0:12d:ff22:d624 with SMTP id a92af1059eb24-1333e4e4224mr100561c88.10.1778532796409;
        Mon, 11 May 2026 13:53:16 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8860ce1bfsm15595665eec.9.2026.05.11.13.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:53:16 -0700 (PDT)
Date: Mon, 11 May 2026 20:53:12 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Aex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] vfio: selftests: Add iommufd multi iommu test
Message-ID: <agI6peKFWDdn939Z@google.com>
References: <20260505221518.619123-1-skhawaja@google.com>
 <20260505221518.619123-3-skhawaja@google.com>
 <af5EEN8PhVz4pTdE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <af5EEN8PhVz4pTdE@google.com>

On Fri, May 08, 2026 at 08:14:08PM +0000, David Matlack wrote:
>On 2026-05-05 10:14 PM, Samiullah Khawaja wrote:
>> Add a test for iommufd to verify creation of multiple iommus using an
>> already setup iommufd and switch between them.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  tools/testing/selftests/vfio/Makefile         |   1 +
>>  .../vfio/vfio_iommufd_multi_iommu_test.c      | 203 ++++++++++++++++++
>>  2 files changed, 204 insertions(+)
>>  create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c
>>
>> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
>> index 0684932d91bf..24bdeaad590f 100644
>> --- a/tools/testing/selftests/vfio/Makefile
>> +++ b/tools/testing/selftests/vfio/Makefile
>> @@ -8,6 +8,7 @@ else
>>  CFLAGS = $(KHDR_INCLUDES)
>>  TEST_GEN_PROGS += vfio_dma_mapping_test
>>  TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
>> +TEST_GEN_PROGS += vfio_iommufd_multi_iommu_test
>>  TEST_GEN_PROGS += vfio_iommufd_setup_test
>>  TEST_GEN_PROGS += vfio_pci_device_test
>>  TEST_GEN_PROGS += vfio_pci_device_init_perf_test
>> diff --git a/tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c b/tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c
>> new file mode 100644
>> index 000000000000..7199c662637c
>> --- /dev/null
>> +++ b/tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c
>> @@ -0,0 +1,203 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <sys/ioctl.h>
>> +#include <sys/mman.h>
>> +
>> +#include <linux/sizes.h>
>> +#include <linux/vfio.h>
>> +
>> +#include <libvfio.h>
>> +
>> +#include "kselftest_harness.h"
>> +
>> +static const char *device_bdf;
>> +
>> +#define IOMMU_DEFAULT 0
>> +#define IOMMU_WITH_PT 1
>> +#define IOMMU_WITHOUT_PT 2
>> +
>> +static void region_setup(struct iommu *iommu,
>> +			 struct iova_allocator *iova_allocator,
>> +			 struct dma_region *region, u64 size)
>> +{
>> +	const int flags = MAP_SHARED | MAP_ANONYMOUS;
>> +	const int prot = PROT_READ | PROT_WRITE;
>> +	void *vaddr;
>> +
>> +	vaddr = mmap(NULL, size, prot, flags, -1, 0);
>> +	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
>> +
>> +	region->vaddr = vaddr;
>> +	region->iova = iova_allocator_alloc(iova_allocator, size);
>> +	region->size = size;
>> +
>> +	iommu_map(iommu, region);
>> +}
>> +
>> +static void region_teardown(struct iommu *iommu, struct dma_region *region)
>> +{
>> +	iommu_unmap(iommu, region);
>> +	VFIO_ASSERT_EQ(munmap(region->vaddr, region->size), 0);
>> +}
>
>Can you create library helpers in the library to share with
>vfio_pci_driver_test.c?
>
>  dma_region_setup()
>  dma_region_teardown()

I thought it is ok to duplicate this as each test (in future) might have
different mapping requirements? we might have memfd, guest_memfd,
dma_buf with various mapping strategies for different usecases?

Or you are thinking of a basic helper that can be used by tests if they
are not doing anything fancy?
>
>> +
>> +FIXTURE(vfio_iommufd_multi_iommu_test) {
>> +	struct iommu *iommu;
>> +	struct vfio_pci_device *device;
>> +	struct iova_allocator *iova_allocator;
>> +	struct dma_region memcpy_region;
>> +	void *vaddr;
>> +
>> +	u64 size;
>> +	void *src;
>> +	void *dst;
>> +	iova_t src_iova;
>> +	iova_t dst_iova;
>> +};
>> +
>> +FIXTURE_SETUP(vfio_iommufd_multi_iommu_test)
>> +{
>> +	struct vfio_pci_driver *driver;
>> +
>> +	self->iommu = iommu_init("iommufd");
>
>MODE_IOMMUFD

Will update.
>
>> +	self->device = vfio_pci_device_init(device_bdf, self->iommu);
>> +	self->iova_allocator = iova_allocator_init(self->iommu);
>> +
>> +	driver = &self->device->driver;
>> +
>> +	region_setup(self->iommu, self->iova_allocator, &self->memcpy_region, SZ_1G);
>> +	region_setup(self->iommu, self->iova_allocator, &driver->region, SZ_2M);
>> +
>> +	if (driver->ops)
>> +		vfio_pci_driver_init(self->device);
>> +
>> +	self->size = self->memcpy_region.size / 2;
>> +	self->src = self->memcpy_region.vaddr;
>> +	self->dst = self->src + self->size;
>> +
>> +	self->src_iova = to_iova(self->device, self->src);
>> +	self->dst_iova = to_iova(self->device, self->dst);
>> +}
>> +

[snip]
>> +static void test_memcpy(struct vfio_pci_device *device, void *src, void *dst,
>> +			iova_t src_iova, iova_t dst_iova, u64 size, char val)
>> +{
>> +	if (!device->driver.ops)
>> +		return;
>> +
>> +	memset(src, val, size);
>> +	memset(dst, 0, size);
>> +
>> +	vfio_pci_driver_memcpy_start(device, src_iova, dst_iova, size, 100);
>
>Why do 100 copies?

Will remove in next revision.
>
>> +	VFIO_ASSERT_EQ(vfio_pci_driver_memcpy_wait(device), 0);
>> +	VFIO_ASSERT_EQ(memcmp(src, dst, size), 0);
>> +}
>> +
>> +TEST_F(vfio_iommufd_multi_iommu_test, memcpy)
>> +{
>> +	struct dma_region memcpy_region1, driver_region1;
>> +	struct dma_region memcpy_region2, driver_region2;
>> +	struct iommu *iommu1;
>> +	struct iommu *iommu2;
>> +
>> +	iommu1 = setup_variant_iommu(self->iommu, self->device->dev_id,
>> +				     variant->start_iommu);
>> +	if (iommu1 != self->iommu) {
>> +		memcpy_region1 = self->memcpy_region;
>> +		driver_region1 = self->device->driver.region;
>> +
>> +		iommu_map(iommu1, &memcpy_region1);
>
>Can you make a helper to copy dma_region into a new iommu? It should set
>up the new struct dma_region based on the old one, re-initialize the
>link field, and then call iommu_map().

Can you please clarify, I didn't get it completely. so basically
something that can be called like following?

setup_copy_dma_regions(self, iommu1, &memcpy_region1, &driver_region1);

I think I get that you are concerned about link init. Maybe I can do?

int clone_dma_region(struct dma_region *source_region,
                      struct dma_region *dest_region);

We can maybe add it to the library?
>
>> +		iommu_map(iommu1, &driver_region1);
>> +
>> +		vfio_pci_device_attach_iommu(self->device, iommu1);
>> +	}
>> +
>> +	test_memcpy(self->device, self->src, self->dst, self->src_iova,
>> +		    self->dst_iova, self->size, 'x');
>
>nit: You can pass in self to avoid unpacking it in every call to
>test_memcpy(). The type would be:
>
>  struct _test_data_vfio_iommufd_multi_iommu_test *self

Agreed. Will do.
>
>> +
>> +	iommu2 = setup_variant_iommu(self->iommu, self->device->dev_id,
>> +				     variant->end_iommu);
>> +	if (iommu2 != self->iommu) {
>> +		memcpy_region2 = self->memcpy_region;
>> +		driver_region2 = self->device->driver.region;
>> +
>> +		iommu_map(iommu2, &memcpy_region2);
>> +		iommu_map(iommu2, &driver_region2);
>> +	}
>> +
>> +	vfio_pci_device_attach_iommu(self->device, iommu2);
>> +	test_memcpy(self->device, self->src, self->dst, self->src_iova,
>> +		    self->dst_iova, self->size, 'a');
>
>test_memcpy() zeroes self->dst every time so do you need to use a
>different character for each call?

I will update this.
>
>> +
>> +	vfio_pci_device_attach_iommu(self->device, iommu1);
>> +	test_memcpy(self->device, self->src, self->dst, self->src_iova,
>> +		    self->dst_iova, self->size, '1');
>> +
>> +	if (iommu1 != self->iommu) {
>> +		/* attach back to default iommu for cleanup */
>> +		vfio_pci_device_attach_iommu(self->device, self->iommu);
>> +		iommu_unmap(iommu1, &memcpy_region1);
>> +		iommu_unmap(iommu1, &driver_region1);
>> +		iommu_cleanup(iommu1);
>> +	}
>> +
>> +	if (iommu2 != self->iommu) {
>> +		iommu_unmap(iommu2, &memcpy_region2);
>> +		iommu_unmap(iommu2, &driver_region2);
>
>nit: You don't need to unmap before cleanup. Is this just to exercise
>that unmap works on the variant iommus?

Not really. I thought it is needed. But I think I will keep it to
exercise that. Will add a comment to clarify.
>
>> +		iommu_cleanup(iommu2);
>> +	}
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	device_bdf = vfio_selftests_get_bdf(&argc, argv);
>> +
>> +	return test_harness_run(argc, argv);
>> +}
>> --
>> 2.54.0.545.g6539524ca2-goog
>>

Thanks,
Sami
