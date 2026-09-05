Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26D264F80
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788581294; cv=none; b=sswxdsyHeZLmy+04Ks/IZ0YcGEvh8w1eWXnaG44gzknONIq/dK9p3xodWJtqavwIXWwpcwi1i59FnBfM1+teemE1lTK3qLa+nYjhNtpOXZKzETpOBnNkCXbfsvHfc6oLBXVaWw0bqOuNK+kX0IhPEPaitPsz5/5JSePJ6DM2R9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788581294; c=relaxed/simple;
	bh=Ogjcy6AWuIiNMoFElPu+5M0YUvjA1DAHyKooz++N5NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7TWQ0oLasxUalVb4y+ldui8aVGqjn0ur2cTRZ4MMcFxinGEHR5Ok7uEJ9ehA2H9WoXV/05JmgqzRi6OAIHszpBP6rOsiVW2bcD270PoBBqTvhX8DARbHvoxN0ReWvYLlVVH4r5hiBwqrSsq7W9Ptpa2KDmQ2TjQLPvCwIa4Y18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h0m9iSVi; arc=none smtp.client-ip=95.215.58.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h0m9iSVi"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ogjcy6AWuIiNMoFElPu+5M0YUvjA1DAHyKooz++N5NU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788581289; v=1; x=1789186089;
 b=h0m9iSViCse/ejJSm8+5HMIXz7cna1EPV225TkyAJuyIJeXjBl/i1XdzNA+khOH3q/PQaElM
 XiAHPsrupi7MmolggXHPIYA9nOvRdo8VsJpXDcXiMCo20SRUog6KGljhmBDmdKfCQP/p6G1kZhM
 sxddT5qZ4EsGtJPFGW9RJL8w=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 92059d4e748b9bc4;
	Sat, 05 Sep 2026 04:07:59 +0000
X-Mizu-Trace-ID: 92059d4e748b9bc4
X-Migadu-Flow: FLOW_OUT
Message-ID: <ffe712c9-6c24-4452-b703-c8e01828ed18@linux.dev>
Date: Fri, 4 Sep 2026 21:07:50 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/20] vfio: selftests: Add
 vfio_pci_liveupdate_kexec_test
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org,
 amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com,
 chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net,
 dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com,
 jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com,
 kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com,
 lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com,
 parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com,
 pratyush@kernel.org, rananta@google.com, rientjes@google.com,
 rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com,
 schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com,
 vivek.kasireddy@intel.com, witu@nvidia.com, yi.l.liu@intel.com,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-18-vipinsh@google.com>
 <0556e2fc-3be5-4023-a9a4-8482fa8c88b2@linux.dev>
 <20260805055042.GA806762.vipinsh@google.com>
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260805055042.GA806762.vipinsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/4 23:02, Vipin Sharma 写道:
> On Tue, Aug 04, 2026 at 03:19:34PM -0700, Yanjun.Zhu wrote:
>> On 7/14/26 8:15 AM, Vipin Sharma wrote:
>>> Add a selftest to exercise preserving a vfio-pci device across a Live
>>> Update. For now the test is extremely simple and just verifies that the
>>> device file can be preserved and retrieved. In the future this test will
>>> be extended to verify more parts about device preservation as they are
>>> implemented.
>>>
>>> This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
>>> manually along with a kexec.
>>>
>>> To run this test manually:
>>>
>>>    $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
>>>    $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0
>>>
>>>    $ kexec ...   # NOTE: Exact method will be distro-dependent
>>>
>>>    $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
>>>    $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 2 0000:00:04.0
>> Hi, Vipin
>>
>> Thanks a lot for your help. I followed your suggestion, vfio-pci setup can
>> work.
> I am glad your setup using virsh is working.
>
>> The followings are the test result. In the step 3, after kexec, there are
>> some fails. I am not sure if these are known problem or not.
>>
>> 1. Before kexec command
>>
>> + modprobe -v vfio-pci
>> + tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
>> + echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override
>> + echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
>> + tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1
>> 0000:00:04.0
>> Preserving device in session
>> Preserving memfd of size 0x40100000 in session
>> # [STAGE 1] Forking persistent child to hold sessions...
>> # [STAGE 1] Child PID: 1236. Resources are pinned.
>> # [STAGE 1] You may now perform kexec reboot.
>> + set +x
>>
>> 2. Run kexec command
>>
>> 3. After kexec command
>>
>> + echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override
>> + echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
>> Checking open(/dev/vfio/devices/vfio0) fails  <--- I can confirm that the
>> /dev/vfio/devices/vfio0 exists. But open this failed.
> This is correct output. Test is verifying that open should fail. If it
> didn't fail the ntest would have exited with an error. A preserved VFIO
> FD can only be retrived using Live Update session ioctls and not through
> usual VFIO dev path.
>
>> Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
>> (vfio_type1_iommu)      <--- fails
>> Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
>> (vfio_type1v2_iommu).  <--- fails
>> Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
>> (iommufd_compat_type1)  <--- fails
>> Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
>> (iommufd_compat_type1v2). <--- fails
> These are all correct output. Test is verifying that userspace should
> not be able to get VFIO device FD only through Live Update session
> ioctls and nothing else.
>
>> Retrieving memfd from LUO
>> Finishing the session before retrieving the device (should fail)
>> Retrieving the device FD from LUO
>> Finishing the session before binding to iommufd (should fail)
>> Binding the device to an iommufd and setting it up
>> Finishing the session
>>
> This is shows VFIO FD is successfully retrived by Live Update ioctl.
>
> So, you saw expected output from successful test run. I will change
> the message getting printed to avoid confusion. I think current way of
> printing ".... fails" is confusing.

Thanks a lot. I have made tests in KVM. I can get the same test results.

Reviewed-and-tested-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>
> Thanks
> Vipin

-- 
Best Regards,
Yanjun.Zhu

