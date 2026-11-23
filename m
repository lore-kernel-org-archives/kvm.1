Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440236;
	b=trlpI0wnfF/wOtVvoTWA8Hdudv5vyDbmjsrKfzvRHA7JE9xJ9lFe4Od2esFGAkyQGiYi
	 d2gDAnQpHe9FEdOt/Y/IxGoG3Ig4SrDn3aDkgRSslL9aS3vAS/YpVIl1V+94U6jSPgBv9
	 AAuCJaNyLW2SivxU1GdUTkxGuMFTQpkFb8/CC3iv/tdwUOEuUSq8aonG9vlMMi5Lgwyfi
	 JNsDL7oovPsO8mNLX2b49E7S/P0LVzEXxBiiWj/6gFc/45NxD8AMk2elkL2509l9T/7h1
	 Qft15CstzzlJe+R9SdznBjg6PpsNmEKA8InUav1GVvOFGdIxHO4wJ/DcbCtEjxQE3HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cuP7SObGgNcigrigLRsAOfRGPC/Kfzad7ThJDALzqv8=;
	b=QOeuRdPuJnFmZ6EagKUHYYsSbXqMU6CZIXRmI/JY0v1q0YKjNgHrUosc8LYyLcfYJdGb
	 PG4Y54Wr1LHI1R3BO+zx/CZ/d/XItqANvYUEinUBEFGV/JI66dwVT3EkWr2nRrT+XUqbt
	 j0pdwMCaKi4q713bpCV1mBceVFWtBbyMcvP/Pf2mOkgvDCRq78IZkRw5eQo6KJ6mPd0Re
	 hJUAl4QJ9Gv0tYSop6zUOCotmHrxE71sPxeGPJO758Tc5gci6OuiMv+UjxpxJnsq2WAeE
	 Ey67EAlIMLulyJy3A8876siNleLJNyz71Ytpyi4+fpZzTGNUGfHLVh/4HKFDnNf1kNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eHI7dyqg;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E9606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 13:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D9E9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eHI7dyqg
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b876afbb86so4083080a12.3
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 05:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795440235; x=1796045035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cuP7SObGgNcigrigLRsAOfRGPC/Kfzad7ThJDALzqv8=;
        b=eHI7dyqgDoqLxjTOY0jKzvZVAN6cfSEbNjPUNZjpWdpjfhLrPxwS5IHVaT+1OwymOE
         7S4NHdc9mTeOaro6PsgWCqMVeyV2N2jZh+i32F3gjf5iMBGhR7xM8M0rakP2n1ESgP/T
         fpCAY/sx0tMUjsUavPxG6bNgbuZrrQYr+jg2uA/RuClQHNhXWn8ZZNDGhBPLU9YZ1JGW
         iTrke77Rhgv/u0TW6Sw4XVqoevk65BNJwYyyUy+E7A3YRHWcfijIkgIHOSzcQD3xo79b
         cLOsmZP3ch+A86wv/0aioW92FuDO+AfSbW4qXNDubETs70PxzwGW5c/UBBSqiQHKg/cH
         N9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440235; x=1796045035;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cuP7SObGgNcigrigLRsAOfRGPC/Kfzad7ThJDALzqv8=;
        b=FGpJjjMdO/xEfdG+hVBtGBX73wnsiu4HPgViqPVT0J6bCFdhmLd+IDLz0ai6DoxKw3
         NsNeHxxEKCGqXqX8yg2rdRe9/G3cN3lh3QG8YuZ/5Xb/H0bdOuKqZNFha+/+Dw4K6oVc
         RT1GNZEcpokzDmn1/WUUX21cqKCbxRPZ+6+gmleM2WbobQFPCKxVrNM5iScv8xICx6Be
         xs/dOsGqxnWShm5CZiKMwuxDPckAla3FjMYSoOIf9EH2m4LkKkuopa+GDWWco8uPes6y
         5PEbjKbWipJ0dET1FN1oLO35fMDXBb1F8RTADLeYTKCaEYT4zY4wDDVWTbBipoOLsADQ
         XrWg==
X-Forwarded-Encrypted: i=1; AL+hErFJQoMicmCU6IRLDVUqFvLADk5TBFnGJvtr/bxBfFw6UahNd3oQRqAkjFzTcLXjGudlAjs=@vger.kernel.org
X-Gm-Message-State: APuU4Z91b7qeA6yZgytbZY+7En3WDCuFRHhPMGnoeQfnoMYdgkpubSFp
	iDu2FKlzg5iG4rmnJEfBsZqHHpFlj30AmLayqfpri+0aKxfc8WUju/hW
X-Gm-Gg: AZFdTZe2A6KizzjMv3Zuz4kYyUH1ud3VS1aUGYqNqa8Y/pEQuQciU2bBUhfjUUVzPOf
	fQVBW2lAsPn+56gP4cgntq6ieAdC/WLz/j5lyII+RxcXGcZoKLk3lxGU3cc95yZt6DopU1gG4y9
	Vr1u2xpmbsX2d0RKiA++LClsyBkpiRoN7SFexVoFq7zWtIFQcq2B66e/Q4UYmMEEuIEzdVI7/Yc
	t2HzAfVoQaEBQFLZdexvRZ+bM3eDiY69r3GObZa1HmsV4iMqHFbIsX99O3T5ZnRui3fu3zIEkI9
	qgqXi+taey/VqG8Vb7OXrrSxMR078U6fH8/K8BWNES6k1hcubqrd/uRoW6CnMZwmV7DC6HtjcaJ
	aCz46AVXMxiJw4sXFN7EiqhMyF5booS8YtM7Pihlk/QPPD6RYHYC8S7JKRphcK8+yPsUpfl/AEv
	GhVrRHUtPuPPbVGDY+ERb/vjeZSpzaCyVgMF6HsAr94CY6ch93fU3Xurl//EmA4oIJDifugly6E
	JrDTF8A1idyxbs2hZ7EHspnMnyee58s+o6B+DA7od1hZHbZ/3f9YsyHjmE8agv9Kh9WkJ2F8e3Y
	NbzW2cr/nglP2o4x05Kpt5uxTfxCGFkdzK5WtWM0TUY9o99pmDDn6PSydTB8EdEBX0DGwARvGmR
	UjX94db4TDrUvN04BUh2HhQ0Gbn2RqEV4wOTPzdae7iDDJMtnkVkF0fpCJPqs6JKuFS8=
X-Received: by 2002:a05:6402:210e:b0:6ba:9d0c:cc83 with SMTP id 4fb4d7f45d1cf-6ba9d0ccee5mr3026054a12.31.1795440234436;
        Mon, 23 Nov 2026 05:23:54 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36d730d1sm5327255a12.0.2026.11.23.05.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:23:53 -0800 (PST)
Date: Mon, 23 Nov 2026 16:23:49 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev, Chengwen Feng <fengchengwen@huawei.com>,
	alex@shazbot.org, jgg@ziepe.ca, helgaas@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	wathsala.vithanage@arm.com, wei.huang2@amd.com, zhipingz@meta.com,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v21 10/13] vfio/pci: Add IV-ST TPH policy and TPH_PROGRAM
 batch programming support
Message-ID: <20261123133843.7qO4iqGj-lkp@intel.com>
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
In-Reply-To: <20261118091238.45992-11-fengchengwen@huawei.com>

Hi Chengwen,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengwen-Feng/PCI-TPH-Fix-pcie_tph_get_st_table_loc-field-extraction/20261118-171226
base:   https://github.com/awilliam/linux-vfio.git next
patch link:    https://lore.kernel.org/r/20261118091238.45992-11-fengchengwen%40huawei.com
patch subject: [PATCH v21 10/13] vfio/pci: Add IV-ST TPH policy and TPH_PROGRAM batch programming support
config: xtensa-randconfig-2200-20261123 (https://download.01.org/0day-ci/archive/20261123/20261123133843.7qO4iqGj-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9187-g5189e3fb

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/20261123133843.7qO4iqGj-lkp@intel.com/

New smatch warnings:
drivers/vfio/pci/vfio_pci_core.c:1889 vfio_pci_core_feature_tph_program() warn: check sign expansion for '-1'
drivers/vfio/pci/vfio_pci_core.c:1890 vfio_pci_core_feature_tph_program() error: we previously assumed 'src_handle' could be null (see line 1873)

vim +1889 drivers/vfio/pci/vfio_pci_core.c

7f5a45f0971e7a Chengwen Feng 2026-11-18  1811  static int vfio_pci_core_feature_tph_program(struct vfio_pci_core_device *vdev,
7f5a45f0971e7a Chengwen Feng 2026-11-18  1812  			u32 flags,
7f5a45f0971e7a Chengwen Feng 2026-11-18  1813  			struct vfio_device_feature_tph_program __user *arg,
7f5a45f0971e7a Chengwen Feng 2026-11-18  1814  			size_t argsz)
7f5a45f0971e7a Chengwen Feng 2026-11-18  1815  {
7f5a45f0971e7a Chengwen Feng 2026-11-18  1816  	struct vfio_device_feature_tph_program program;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1817  	u32 user_flags, src_mask, st_size;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1818  	struct pci_dev *pdev = vdev->pdev;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1819  	bool extended, stop_on_zero;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1820  	u32 *src_handle = NULL;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1821  	int ret, i, k, written;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1822  	u16 *tags = NULL;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1823  	u16 cmd;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1824  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1825  	if (!vdev->tph_opt_in ||
7f5a45f0971e7a Chengwen Feng 2026-11-18  1826  		!vfio_pci_tph_has_architected_st(vdev))
7f5a45f0971e7a Chengwen Feng 2026-11-18  1827  		return -EOPNOTSUPP;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1828  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1829  	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
7f5a45f0971e7a Chengwen Feng 2026-11-18  1830  				 sizeof(program));
7f5a45f0971e7a Chengwen Feng 2026-11-18  1831  	if (ret != 1)
7f5a45f0971e7a Chengwen Feng 2026-11-18  1832  		return ret;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1833  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1834  	if (copy_from_user(&program, arg, sizeof(program)))
7f5a45f0971e7a Chengwen Feng 2026-11-18  1835  		return -EFAULT;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1836  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1837  	user_flags = program.flags;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1838  	extended = !!(user_flags & VFIO_DEVICE_TPH_EXTENDED);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1839  	if (extended && !pcie_ext_tph_supported(vdev->pdev))
7f5a45f0971e7a Chengwen Feng 2026-11-18  1840  		return -EOPNOTSUPP;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1841  	user_flags &= ~VFIO_DEVICE_TPH_EXTENDED;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1842  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1843  	stop_on_zero = !!(user_flags & VFIO_DEVICE_TPH_REQUIRE_ST);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1844  	if (stop_on_zero && (user_flags & VFIO_DEVICE_TPH_SRC_NONE))
7f5a45f0971e7a Chengwen Feng 2026-11-18  1845  		return -EINVAL;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1846  	user_flags &= ~VFIO_DEVICE_TPH_REQUIRE_ST;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1847  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1848  	src_mask = vfio_pci_tph_get_src_mask(vdev);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1849  	if (user_flags & ~src_mask || !is_power_of_2(user_flags))
7f5a45f0971e7a Chengwen Feng 2026-11-18  1850  		return -EINVAL;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1851  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1852  	st_size = vfio_pci_tph_get_st_table_size(vdev);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1853  	if (program.start >= st_size || program.count == 0 ||
7f5a45f0971e7a Chengwen Feng 2026-11-18  1854  		program.count > st_size - program.start)
7f5a45f0971e7a Chengwen Feng 2026-11-18  1855  		return -EINVAL;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1856  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1857  	if (!(user_flags & VFIO_DEVICE_TPH_SRC_NONE)) {
7f5a45f0971e7a Chengwen Feng 2026-11-18  1858  		src_handle = memdup_array_user(u64_to_user_ptr(program.srcs),
7f5a45f0971e7a Chengwen Feng 2026-11-18  1859  					       program.count, sizeof(u32));
7f5a45f0971e7a Chengwen Feng 2026-11-18  1860  		if (IS_ERR(src_handle))
7f5a45f0971e7a Chengwen Feng 2026-11-18  1861  			return PTR_ERR(src_handle);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1862  	}
7f5a45f0971e7a Chengwen Feng 2026-11-18  1863  	tags = kcalloc(program.count, sizeof(u16), GFP_KERNEL_ACCOUNT);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1864  	if (!tags) {
7f5a45f0971e7a Chengwen Feng 2026-11-18  1865  		ret = -ENOMEM;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1866  		goto out;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1867  	}
7f5a45f0971e7a Chengwen Feng 2026-11-18  1868  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1869  	cpus_read_lock();
7f5a45f0971e7a Chengwen Feng 2026-11-18  1870  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1871  	for (i = 0; i < program.count; i++) {
7f5a45f0971e7a Chengwen Feng 2026-11-18  1872  		ret = vfio_pci_tph_resolve_st_tag(pdev, user_flags,
7f5a45f0971e7a Chengwen Feng 2026-11-18 @1873  						src_handle ? src_handle[i] : 0,
7f5a45f0971e7a Chengwen Feng 2026-11-18  1874  						extended, &tags[i]);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1875  		if (ret || (stop_on_zero && tags[i] == 0))
7f5a45f0971e7a Chengwen Feng 2026-11-18  1876  			break;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1877  	}
7f5a45f0971e7a Chengwen Feng 2026-11-18  1878  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1879  	if (i > 0) {
7f5a45f0971e7a Chengwen Feng 2026-11-18  1880  		mutex_lock(&vdev->tph_lock);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1881  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1882  		cmd = vfio_pci_memory_lock_and_enable(vdev);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1883  		ret = written = pcie_tph_set_st_entries(pdev, program.start, i,
7f5a45f0971e7a Chengwen Feng 2026-11-18  1884  							tags);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1885  		vfio_pci_memory_unlock_and_restore(vdev, cmd);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1886  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1887  		if (written > 0) {
7f5a45f0971e7a Chengwen Feng 2026-11-18  1888  			for (k = 0; k < written; k++)
7f5a45f0971e7a Chengwen Feng 2026-11-18 @1889  				vdev->tph_st_cpu[program.start + k] =
7f5a45f0971e7a Chengwen Feng 2026-11-18 @1890  					(tags[k] == 0) ? -1 : src_handle[k];

tph_st_cpu[] is an array of s64 but because of sign expansion
instead of saving -1 to it, we save UINT_MAX.

Smatch is also complaining that src_handle[] might be NULL but that
might be a false positive...  (probably is).

7f5a45f0971e7a Chengwen Feng 2026-11-18  1891  		}
7f5a45f0971e7a Chengwen Feng 2026-11-18  1892  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1893  		mutex_unlock(&vdev->tph_lock);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1894  	}
7f5a45f0971e7a Chengwen Feng 2026-11-18  1895  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1896  	cpus_read_unlock();
7f5a45f0971e7a Chengwen Feng 2026-11-18  1897  
7f5a45f0971e7a Chengwen Feng 2026-11-18  1898  out:
7f5a45f0971e7a Chengwen Feng 2026-11-18  1899  	kfree(tags);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1900  	kfree(src_handle);
7f5a45f0971e7a Chengwen Feng 2026-11-18  1901  	return ret;
7f5a45f0971e7a Chengwen Feng 2026-11-18  1902  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

