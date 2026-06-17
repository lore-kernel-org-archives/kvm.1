Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC73876CF;
	Wed, 17 Jun 2026 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721370; cv=none; b=HvkXwv81wzOtz9fHl64U6I2LGjwxFwE5hDV/aSKsUkcJpBzoLDKu2LdvOseUBnhK4DPT07C2DTTFxjdxj4XMlbalVXP4njZhkDnMIoeGcQLk0wksW8Yf//WSE6UgzB2Ffq6wmRqzz3+7ZpinXcMajniu9RWyKcpDya9WzLRpoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721370; c=relaxed/simple;
	bh=NF3MxxzABB/RAkQQz1nmgKSOVW3XhgMn3EpdAiD8Tsk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0s8Oi1FpTMwzb9/BX7cDcQyXeko2fkTIgG1ObJjAyl0KyrCDVZ3pOFZ+4SyYCJR+FZpH1VvRTIDO/XH1y1HbUwJjOj0d6Lw2pPvvVVJ1q4UinJohUQDuOBpSONH+PXJQXEo/FFzCmbqNewRXrYFN4gUUg9BJjzphtyy2QSztKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=Ns5SkmoR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="Ns5SkmoR"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHdvE8499792;
	Wed, 17 Jun 2026 11:36:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CpzEQMu49VAH+7hFBiin6hegp7MIbSfAR5d4+T0ZuI0=; b=Ns5SkmoRyWSR
	tCt6/RC+kRmGpODoO+Emax+vg+0yuJVOwNRiDXCFpMr+o8m+PAhn+xfjbO7brPJ3
	BvqjpeM4KH1qjGbEyfVX9zlohNjeV7qM0gcrmbSeSouGeCvs9IFzFHQAsre+35vp
	tBmgcM302IZ7fLTrNvZKGFGn2pXkRSfzfQKH9pcCmpQoDNI1o2SpI6DM3e7QMq4v
	LAwH9f1zN8lTeI65/yElPzA0Htz6kCnGYqfG6Ax2CwRyFEvyyKFhB2yYXxIMXIcA
	aXn2j8SVHxT8pfmFybYMRSaycQHJrk+DF5O+knTcRZpR71LrhEqtSszjVNyafvhh
	zclJfz9A7Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4euegqxfnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Jun 2026 11:36:01 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 17 Jun 2026 18:36:00 +0000
Date: Wed, 17 Jun 2026 11:35:52 -0700
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Vipin Sharma
	<vipinsh@google.com>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 1/2] vfio: selftests: Add calloc_assert() helper
Message-ID: <ajLpCCbqhPYLkd15@devgpu015.cco6.facebook.com>
References: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com>
 <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-1-b3798415c72a@fb.com>
 <CALzav=ekpRKjyUTNax17SRMHg21OHa4Jq3OGzu+Y0TXW12EeJQ@mail.gmail.com>
 <ajF0Fistyj7SXlDi@devgpu015.cco6.facebook.com>
 <CALzav=cbgg=09hyRb0nnrjGF8qn2Tn5uSEsZa7i7bTtviVynNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cbgg=09hyRb0nnrjGF8qn2Tn5uSEsZa7i7bTtviVynNQ@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=Cbk4Irrl c=1 sm=1 tr=0 ts=6a32e911 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22 a=FOH2dFAWAAAA:8
 a=jGBhGEbKD5VQjbqLd_kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uTg9P5cbSKcEqP02RF4TvcN_gKfTeoHi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE3OSBTYWx0ZWRfX5W1pStlZ+NN9
 FRTxLaKyeBv+cQGu7oN5zJr6G8V1JLiiQSAu2L/KXL/olstKpPotXYXrozt2lhRk3rx20aOQ7kd
 RWFpBATKXTW4DfhHNTGtOaii8E6wxf1CtHdN/H7txt4TK3rQt2F1E+h30OkfqRM2LfNL3u/oOB6
 NtPToo6uPCNFipT4Wv9XOmc8otjl2W2HuucM8IYs5MdBzIU//QtxrqXKgFZQtWFLRzuQeWR8T8A
 9ejVuxfdqEhFVl1Ic5CrqGFEVNlWoOUJRH1s5ga5kmRJOSUef0OOE5YVCtb0j0QsUol+52owbkh
 twftosZAthZXt13ueplYDG4E9SvnDLmba+UIUJL8G9xkNS+0YmeZF1LYukuwSGyEVJOBGj2CX0p
 42en2T0m/ETXezkeuXb3UtAGdp8qKHO0HZNOSmBoN+2+TDry527VeCmDmvk1TYwDqnokX8LYPNa
 GubqQ2JTuJDQxZ/f6BQ==
X-Proofpoint-ORIG-GUID: uTg9P5cbSKcEqP02RF4TvcN_gKfTeoHi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE3OSBTYWx0ZWRfX1221y97OukZp
 jQM7HoVaB2pWiGiMX1SKH78X9uXxJxaSCD21xqGB3uhAlRK/CQzKaulJxk9XkqZWwMLHXXB/Il6
 xe//obs/CK85WJUTKn4BE30uAyCyrhI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01

On Wed, Jun 17, 2026 at 08:30:08AM -0700, David Matlack wrote:
> On Tue, Jun 16, 2026 at 9:04 AM Alex Mastro <amastro@fb.com> wrote:
> >
> > On Mon, Jun 15, 2026 at 03:51:26PM -0700, David Matlack wrote:
> > > On Mon, Jun 15, 2026 at 12:45 PM Alex Mastro <amastro@fb.com> wrote:
> > > >
> > > > Add a calloc_assert() helper alongside the existing ioctl_assert() and
> > > > snprintf_assert() helpers.
> > > >
> > > > Use it for VFIO selftest allocations that immediately assert a
> > > > non-NULL result.
> > > >
> > > > Assisted-by: Codex:gpt-5.5-high
> > > > Signed-off-by: Alex Mastro <amastro@fb.com>
> > > > ---
> > > >  tools/testing/selftests/vfio/lib/include/libvfio/assert.h    | 10 ++++++++++
> > > >  tools/testing/selftests/vfio/lib/iommu.c                     | 12 ++++--------
> > > >  tools/testing/selftests/vfio/lib/iova_allocator.c            |  4 +---
> > > >  tools/testing/selftests/vfio/lib/sysfs.c                     |  3 +--
> > > >  tools/testing/selftests/vfio/lib/vfio_pci_device.c           |  6 ++----
> > > >  .../testing/selftests/vfio/vfio_pci_device_init_perf_test.c  |  4 ++--
> > > >  6 files changed, 20 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> > > > index 77b68c7129a6..f0490a403826 100644
> > > > --- a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> > > > +++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> > > > @@ -3,6 +3,7 @@
> > > >  #define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H
> > > >
> > > >  #include <stdio.h>
> > > > +#include <stdlib.h>
> > > >  #include <string.h>
> > > >  #include <sys/ioctl.h>
> > > >
> > > > @@ -45,6 +46,15 @@
> > > >         VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);                 \
> > > >  } while (0)
> > > >
> > > > +#define calloc_assert(_nmemb, _size) ({                                \
> > > > +       size_t __nmemb = (_nmemb);                              \
> > > > +       size_t __size = (_size);                                \
> > > > +       void *__ptr = calloc(__nmemb, __size);                  \
> > > > +       VFIO_ASSERT_NOT_NULL(__ptr, "calloc(%zu, %zu) failed",  \
> > > > +                            __nmemb, __size);                  \
> > > > +       __ptr;                                                  \
> > > > +})
> > > > +
> > > >  #define ioctl_assert(_fd, _op, _arg) do {                                                     \
> > > >         void *__arg = (_arg);                                                                  \
> > > >         int __ret = ioctl((_fd), (_op), (__arg));                                              \
> > > > diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
> > > > index 035dac069d60..31aba9fda8e5 100644
> > > > --- a/tools/testing/selftests/vfio/lib/iommu.c
> > > > +++ b/tools/testing/selftests/vfio/lib/iommu.c
> > > > @@ -286,8 +286,7 @@ static struct vfio_iommu_type1_info *vfio_iommu_get_info(int container_fd)
> > > >  {
> > > >         struct vfio_iommu_type1_info *info;
> > > >
> > > > -       info = malloc(sizeof(*info));
> > > > -       VFIO_ASSERT_NOT_NULL(info);
> > > > +       info = calloc_assert(1, sizeof(*info));
> > > >
> > > >         *info = (struct vfio_iommu_type1_info) {
> > > >                 .argsz = sizeof(*info),
> > > > @@ -324,8 +323,7 @@ static struct iommu_iova_range *vfio_iommu_iova_ranges(struct iommu *iommu,
> > > >         cap_range = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range, header);
> > > >         VFIO_ASSERT_GT(cap_range->nr_iovas, 0);
> > > >
> > > > -       ranges = calloc(cap_range->nr_iovas, sizeof(*ranges));
> > > > -       VFIO_ASSERT_NOT_NULL(ranges);
> > > > +       ranges = calloc_assert(cap_range->nr_iovas, sizeof(*ranges));
> > > >
> > > >         for (u32 i = 0; i < cap_range->nr_iovas; i++) {
> > > >                 ranges[i] = (struct iommu_iova_range){
> > > > @@ -357,8 +355,7 @@ static struct iommu_iova_range *iommufd_iova_ranges(struct iommu *iommu,
> > > >         VFIO_ASSERT_EQ(errno, EMSGSIZE);
> > > >         VFIO_ASSERT_GT(query.num_iovas, 0);
> > > >
> > > > -       ranges = calloc(query.num_iovas, sizeof(*ranges));
> > > > -       VFIO_ASSERT_NOT_NULL(ranges);
> > > > +       ranges = calloc_assert(query.num_iovas, sizeof(*ranges));
> > > >
> > > >         query.allowed_iovas = (uintptr_t)ranges;
> > > >
> > > > @@ -424,8 +421,7 @@ struct iommu *iommu_init(const char *iommu_mode)
> > > >         struct iommu *iommu;
> > > >         int version;
> > > >
> > > > -       iommu = calloc(1, sizeof(*iommu));
> > > > -       VFIO_ASSERT_NOT_NULL(iommu);
> > > > +       iommu = calloc_assert(1, sizeof(*iommu));
> > > >
> > > >         INIT_LIST_HEAD(&iommu->dma_regions);
> > > >
> > > > diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/testing/selftests/vfio/lib/iova_allocator.c
> > > > index 8c1cc86b70cd..2e7d54e1b4c6 100644
> > > > --- a/tools/testing/selftests/vfio/lib/iova_allocator.c
> > > > +++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
> > > > @@ -29,8 +29,7 @@ struct iova_allocator *iova_allocator_init(struct iommu *iommu)
> > > >         ranges = iommu_iova_ranges(iommu, &nranges);
> > > >         VFIO_ASSERT_NOT_NULL(ranges);
> > > >
> > > > -       allocator = malloc(sizeof(*allocator));
> > > > -       VFIO_ASSERT_NOT_NULL(allocator);
> > > > +       allocator = calloc_assert(1, sizeof(*allocator));
> > >
> > > Did you mean to replace malloc() with calloc()? Feel free to add a
> > > malloc_assert().
> >
> > Yes! Since all malloc() can be expressed as calloc() (because we shouldn't care
> > about potentially redundant zeroing overhead), I think the single
> > calloc_assert() is fine.
> 
> I agree the extra zeroing overhead is not a big deal for these
> allocations. But it is odd to see calloc being used where it is not
> needed, and there may be future users that truly want a
> malloc_assert() over calloc_assert(). Let's just add a malloc_assert()
> in this patch. It should be a simple change.

SGTM - I'll add it in v4.

> 
> >
> > >
> > > >
> > > >         *allocator = (struct iova_allocator){
> > > >                 .ranges = ranges,
> > > > @@ -90,4 +89,3 @@ iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
> > > >                 allocator->range_offset = 0;
> > > >         }
> > > >  }
> > > > -
> > > > diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
> > > > index 11415448b2e2..98a46a2543cd 100644
> > > > --- a/tools/testing/selftests/vfio/lib/sysfs.c
> > > > +++ b/tools/testing/selftests/vfio/lib/sysfs.c
> > > > @@ -107,8 +107,7 @@ char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i)
> > > >         char *out_vf_bdf;
> > > >
> > > >         /* Fit "0000:00:00.0" */
> > > > -       out_vf_bdf = calloc(16, sizeof(char));
> > > > -       VFIO_ASSERT_NOT_NULL(out_vf_bdf);
> > > > +       out_vf_bdf = calloc_assert(16, sizeof(char));
> > > >
> > > >         snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/virtfn%d", pf_bdf, i);
> > > >         readlink_base(path, "%s", out_vf_bdf);
> > > > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > > index 94dc5fcecbeb..eb40f7159bae 100644
> > > > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > > @@ -343,8 +343,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
> > > >         char *cdev_path;
> > > >         DIR *dir;
> > > >
> > > > -       cdev_path = calloc(PATH_MAX, 1);
> > > > -       VFIO_ASSERT_NOT_NULL(cdev_path);
> > > > +       cdev_path = calloc_assert(PATH_MAX, 1);
> > > >
> > > >         snprintf_assert(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
> > > >
> > > > @@ -425,8 +424,7 @@ struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iom
> > > >  {
> > > >         struct vfio_pci_device *device;
> > > >
> > > > -       device = calloc(1, sizeof(*device));
> > > > -       VFIO_ASSERT_NOT_NULL(device);
> > > > +       device = calloc_assert(1, sizeof(*device));
> > > >
> > > >         VFIO_ASSERT_NOT_NULL(iommu);
> > > >         device->iommu = iommu;
> > > > diff --git a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
> > > > index 33b0c31fe2ed..e1a54e153cd3 100644
> > > > --- a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
> > > > +++ b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
> > > > @@ -45,8 +45,8 @@ FIXTURE_SETUP(vfio_pci_device_init_perf_test)
> > > >         int i;
> > > >
> > > >         self->iommu = iommu_init(variant->iommu_mode);
> > > > -       self->threads = calloc(nr_devices, sizeof(self->threads[0]));
> > > > -       self->thread_args = calloc(nr_devices, sizeof(self->thread_args[0]));
> > > > +       self->threads = calloc_assert(nr_devices, sizeof(self->threads[0]));
> > > > +       self->thread_args = calloc_assert(nr_devices, sizeof(self->thread_args[0]));
> > > >
> > > >         pthread_barrier_init(&self->barrier, NULL, nr_devices);
> > > >
> > > >
> > > > --
> > > > 2.53.0-Meta
> > > >
